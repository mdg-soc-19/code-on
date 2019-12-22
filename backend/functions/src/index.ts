import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const collaborativeFiltering = functions.https.onRequest(
  async (request, response) => {
    admin.initializeApp();
    const uid = request.query.uid;
    console.log("Query is made by :- " + uid);
    const userSnapshot = await admin
      .firestore()
      .doc("userData/" + uid)
      .get();
    const user: String = userSnapshot.get("username");

    //Getting userData from firestore.
    const userDataSnapshot = await admin
      .firestore()
      .collectionGroup("userData")
      .get();
    const userList: String[] = [];
    const userData: String[][] = [];
    userDataSnapshot.forEach(doc => {
      userList.push(doc.get("username"));
      userData.push(doc.get("arrayOfProblems"));
    });

    //Getting problemSet from  firestore.
    const problemSetSnapshot = await admin
      .firestore()
      .collection("problemSet")
      .doc("current")
      .get();
    let problemSet: String[] = [];
    problemSet = problemSetSnapshot.get("arrayOfProblems");

    // //Generating fake raw data for testing.
    // const userList: String[] = ["a", "b", "c", "d", "e"];
    // const userData: String[][] = [
    //   ["1A", "1B", "1C", "1D"],
    //   ["1A", "1B", "1D"],
    //   ["2A", "2B", "2C", "4A", "4B"],
    //   ["3A", "3B"],
    //   ["1A", "2A", "3A"]
    // ];
    // const problemSet: String[] = [
    //   "1A",
    //   "1B",
    //   "1C",
    //   "1D",
    //   "2A",
    //   "2B",
    //   "2C",
    //   "3A",
    //   "3B",
    //   "4A",
    //   "4B",
    //   "4C",
    //   "4D"
    // ];

    //Logging the raw info.
    console.log(problemSet);
    console.log(userData);
    console.log(userList);
    console.log(user);

    //Generating and Normalizing dataset.
    const dataset: number[][] = [];
    for (let i = 0; i < userList.length; i++) {
      dataset[i] = [];
      const normalizedIndex = 1 / userData[i].length;
      for (let j = 0; j < problemSet.length; j++) {
        if (userData[i].indexOf(problemSet[j]) !== -1) {
          dataset[i][j] = normalizedIndex;
        } else {
          dataset[i][j] = 0;
        }
      }
    }
    const userIndex: number = userList.indexOf(user);

    //#################################Item Based Collaborative Filtering#################################
    //Generating the item-similarity matrix.
    const iimat: number[][] = [];
    for (let i = 0; i < problemSet.length; i++) {
      iimat[i] = [];
    }
    for (let i = 0; i < problemSet.length; i++) {
      for (let j = i; j < problemSet.length; j++) {
        let sumproduct: number = 0;
        let sqsumi: number = 0;
        let sqsumj: number = 0;
        for (let k = 0; k < userList.length; k++) {
          sumproduct += dataset[k][i] * dataset[k][j];
          sqsumi += dataset[k][i] * dataset[k][i];
          sqsumj += dataset[k][j] * dataset[k][j];
        }
        if (sumproduct === 0) {
          iimat[i][j] = 0;
          iimat[j][i] = 0;
        } else if (sqsumi === 0 || sqsumj === 0) {
          iimat[i][j] = 0;
          iimat[j][i] = 0;
        } else {
          const sqrsqsumi = Math.sqrt(sqsumi);
          const sqrsqsumj = Math.sqrt(sqsumj);
          iimat[i][j] = sumproduct / (sqrsqsumi * sqrsqsumj);
          iimat[j][i] = sumproduct / (sqrsqsumi * sqrsqsumj);
        }
      }
    }

    // Generating recommendations for Item Based Collaborative Filtering
    const recommendationsI: number[] = [];
    for (let i = 0; i < problemSet.length; i++) {
      let prsum: number = 0;
      let sum1: number = 0;
      for (let j = 0; j < problemSet.length; j++) {
        prsum += dataset[userIndex][j] * iimat[i][j];
        sum1 += iimat[i][j];
      }
      if (sum1 === 0) {
        recommendationsI[i] = 0;
      } else {
        recommendationsI[i] = prsum / sum1;
      }
    }

    //#################################User Based Collaborative Filtering#################################
    //Generating the user-similarity matrix.
    const uumat: number[][] = [];
    for (let i = 0; i < userList.length; i++) {
      uumat[i] = [];
    }
    for (let i = 0; i < userList.length; i++) {
      for (let j = i; j < userList.length; j++) {
        let sumproduct: number = 0;
        let sqsumi: number = 0;
        let sqsumj: number = 0;
        for (let k = 0; k < problemSet.length; k++) {
          sumproduct += dataset[i][k] * dataset[j][k];
          sqsumi += dataset[i][k] * dataset[i][k];
          sqsumj += dataset[j][k] * dataset[j][k];
        }
        if (sumproduct === 0) {
          uumat[i][j] = 0;
          uumat[j][i] = 0;
        } else if (sqsumi === 0 || sqsumj === 0) {
          uumat[i][j] = 0;
          uumat[j][i] = 0;
        } else {
          const sqrsqsumi = Math.sqrt(sqsumi);
          const sqrsqsumj = Math.sqrt(sqsumj);
          uumat[i][j] = sumproduct / (sqrsqsumi * sqrsqsumj);
          uumat[j][i] = sumproduct / (sqrsqsumi * sqrsqsumj);
        }
      }
    }

    //Generating recommendations for User Based Collaborative Filtering
    const recommendationsU: number[] = [];
    let sum: number = 0;
    for (let i = 0; i < userList.length; i++) {
      sum += uumat[userIndex][i];
    }
    for (let i = 0; i < problemSet.length; i++) {
      let psum: number = 0;
      for (let j = 0; j < userList.length; j++) {
        psum += dataset[j][i] * uumat[userIndex][j];
      }
      recommendationsU[i] = psum / sum;
    }

    //Logging results.
    console.log(dataset);
    console.log(iimat);
    console.log(recommendationsI);
    console.log(recommendationsU);

    response.send([recommendationsI, recommendationsU]);
  }
);

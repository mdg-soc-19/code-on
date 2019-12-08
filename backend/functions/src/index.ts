import * as functions from "firebase-functions";
// import * as admin from "firebase-admin";

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const generateRecommendation = functions.https.onRequest(
  (request, response) => {
    var uid = request.query.uid;
    console.log("Query is made by :- " + uid);
    response.send("Hello from Firebase! " + uid);
  }
);

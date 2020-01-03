# Code On

A Flutter application that supliments CodeForces by providing a recommendation system.

## Curent Progress

Complete :-

- Authentication.
- Firestore for problems.
- Cloud Functions to generate recommendations.
- UI to present generated recommendations.

Under Progress:-

- Bug fixes and adding minor features.

## Algorithm

To generate recommendation Collaborative filtering is used on the data fetched from CodeForces API and stored in Firestore Database. Collaborative filtering is a technique that can filter out items that a user might like on the basis of reactions by similar users or items.There are 2 major types of Collaborative filtering in use:-

#### User Based CF

Users similar to the target users are found and the selections corresponding to these 'similar' users are recommended to our target user. The similarity between two users is computed from the amount of items they have in common in the dataset by cosine similarity. This algorithm is very efficient when the number of users is way smaller than the number of items. The major drawback is that adding a new user is expensive since it requires to update all similarities between users.

#### Item Based CF

The “item-item” algorithm uses the same approach but reverses the view between users and items. It recommends items that are similar to the ones previously liked by the target user. As before the similarity between two items is computed using the amount of users they have in common in the dataset by cosine similarity. This algorithm is best when the number of items is way smaller than the number of users.

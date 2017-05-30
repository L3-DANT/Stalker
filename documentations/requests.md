# Communication vers l'API

## Sommaire
* Résumé
* Client
* Serveur
* WebSockets
* Méthodes
* Collections
	* Collection: /friend/
	* Collection: /user/
	* Collection: /position/
	* Collection: /meetpoint/

# Résumé
* Les messages envoyés à l'API seront sous:
	* `application/json`: pour l'envoi de message.
	* L'interaction avec l'API se fera en **REST**.
	* Les réponses de l'API seront en **JSON**.

# Client
L'application enverra des message sous la forme:<br>
*JSON, example:*
```json
{
	"name": "john doe",
	"email": "john.doe@protonmail.ch",
	"password": "dsfsq24d4sf25df4s"
}
```
> Note: les données envoyés diffèrent suivant la ressource distante.

# Serveur
L'API répondra en JSON, sous la forme:
```json
{
	"email": "john.doe@protonmail.ch",
	"password": "dsfsq24d4sf25df4s",
	"token": "sb4gom7igsdgh5fd9jmk"
}
```
> Note: les données reçues diffèrent elles aussi suivant la ressource distante.

# WebSockets
Le client iOS a l'initiative de la création du channel et des requêtes:
 * le client s'abonne à un channel privé en s'athentifiant avec son token
 * le serveur vérifie la validité du token et renvoie une requête avec un String
 d'authentification sous la forme :
```json
 {
  "auth":"278d425bdf160c739803:a99e78e7cd40dcd0d4ae06be0a5395b6cd3c085764229fd40b39ce92c39af33e"
}
```
 * le client envoie des requêtes pour envoyer sa position ou récupérer la position de ses amis
 * le serveur y répond

* DOC Java : https://github.com/pusher/pusher-http-java
* DOC Swift : https://pusher.com/docs/client_api_guide

# Méthodes
Les méthodes HTTP utilisé seront:

* `DELETE`	: supprime des (ressources|informations|méta-données|fichiers).
* `GET`		: (récupère|liste) des (ressources|informations|méta-données|fichiers).
* `POST`	: envoi des (informations|méta-données).
* `PUT`		: (créer|met à jour) un fichier.

# Collections
> Note:
> * **/friend/**	: collection des relations d'amis.<br>
> * **/user/**		: collection des utilisateurs.<br>
> * **/position/**	: collection des positions.<br>
> * **/meetpoint/**	: collection de lieux.

## Collection: /friend/
* **GET** :
	* /friend		: récupère la liste des amis et des demandes d'amis de l'utilisateur actuellement connecté.
	* /friend/?isAccepted=true	: récupère la liste des amis de l'utilisateur actuellement connecté.
	* /friend/?isAccepted=false	: récupère la liste des demandes d'amis de l'utilisateur actuellement connecté.
* **POST** :
	* /friend/		: créer une demande d'ami.
* **PUT** :
	* /friend/			: accepte une demande d'ami.
* **DELETE** :
	* /friend/		: supprime la relations.

## Collection: /user/
* **POST** :
	* /user/			: créer l'utilisateur.
	* /user/me/			: connectecréer un utilisateur.
* **PUT** :
	* /user/			: met à jour les données de l'utilisateur actuellement connecté.
* **DELETE** :
	* /user/			: supprime l'utilisateur actuellement connecté.

## Collection: /position/
* **GET** :
	* /position/*[id-user]*			: récupère les positions de l'utilisateur `[id-user]`.
	* /position/last/*[id-user]*		: récupère la plus récente position de l'utilisateur `[id-user]`.
* **POST** :
	* /position/				: ajoute une position de l'utilisateur actuellement connecté.

## Collection: /meetpoint/
* **GET** :
	* /meetpoint/				: récupère tous les meetpoints de l'utilisateur actuellement connecté.
* **POST** :
	* /meetpoint/				: ajoute un meetpoint.
* **PUT** :
	* /meetpoint/				: modifie un meetpoint.
* **DELETE** :
	* /meetpoint/				: supprime un meetpoint.

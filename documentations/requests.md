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
Le client iOS a des requêtes:
 * Par requête REST sur /api/user, l'application s'authentifie
 * Le serveur renvoie un token à l'application et s'abonne au channel portant le nom du token
 * le client s'abonne au channel portant le nom du token
 * le client envoie sa position par WebSocket
 * le serveur y répond par WebSocket en transmettant la dernière position de ses amis

* DOC Java : https://pusher.com/docs/android_quick_start
* DOC Swift : https://pusher.com/docs/ios_quick_start

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
	* /friend/getfriends		: récupère la liste des amis de l'utilisateur actuellement connecté. (actuellement)
	* /friend/getdemands		: récupère la liste des demandes d'amis de l'utilisateur actuellement connecté. (actuellement)
	* /friend/?isAccepted=true	: récupère la liste des amis de l'utilisateur actuellement connecté. (objectif)
	* /friend/?isAccepted=false	: récupère la liste des demandes d'amis de l'utilisateur actuellement connecté. (objectif)
* **POST** :
	* /friend/		: créé une demande d'ami.
* **PUT** :
	* /friend/			: accepte une demande d'ami.
* **DELETE** :
	* /friend/		: supprime la relations.

## Collection: /user/
* **POST** :
	* /user/			: créé l'utilisateur.
	* /user/me/			: connecte un utilisateur.
* **PUT** :
	* /user/			: met à jour les données de l'utilisateur actuellement connecté.
* **DELETE** :
	* /user/			: supprime l'utilisateur actuellement connecté.

## Collection: /position/
* **GET** :
	* /position/*[email-user]*			: récupère les positions de l'utilisateur `[email-user]`.
	* /position/last/*[email-user]*		: récupère la plus récente position de l'utilisateur `[email-user]`.
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

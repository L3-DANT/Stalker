# Comminication vers l'API

## Sommaire
* Résumé
* Client
* Serveur
* Méthodes
* Collections
	* Collection: /friendship/
	* Collection: /user/
	* Collection: /position/
	* Collection: /meetpoint/

# Résumé
* Les messages envoyé à l'API sera sous:
	* `application/json`: pour l'envoi de message.
	* `multipart/form-data`: pour l'envoi de données tel quel, utilisé pour l'envoi de fichier.
* L'intéraction avec l'API se fera en **REST**.
* Les réponse de l'API sera en **JSON**.

# Client
L'application envera des message sous la forme:<br>
*JSON, example:*
```json
{
	"name": "john doe",
	"email": "john.doe@protonmail.ch",
	"password": "dsfsq24d4sf25df4s"
}
```
> Note: les données envoyé diffèrent suivant la ressource distante.

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

# Méthodes
Les méthodes HTTP utilisé seront:

* `DELETE`	: supprime des (ressources|informations|méta-données|fichiers).
* `GET`		: (récupère|liste) des (ressources|informations|méta-données|fichiers).
* `POST`	: envoi des (informations|méta-données).
* `PUT`		: (créer|met à jour) un fichier.

# Collections
> Note:
> * **/friendship/**	: collection des relations d'amis.<br>
> * **/user/**		: collection des utilisateurs.<br>
> * **/position/**	: collection des positions.<br>
> * **/meetpoint/**	: collection de lieux.

## Collection: /friends/
* **GET** :
	* /friends		: récupère la liste des amis et des demandes d'amis de l'utilisateur actuellement connecté.
	* /friends/getfriends	: récupère la liste des amis de l'utilisateur actuellement connecté.
	* /friends/getdemands	: récupère la liste des demandes d'amis de l'utilisateur actuellement connecté.
* **POST** :
	* /friends/		: créer une demande d'ami.
	* /friends/acceptfriend	: accepte une demande d'ami.
* **DELETE** :
	* /friends/		: supprime la relations.

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

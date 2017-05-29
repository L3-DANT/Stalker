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
> Note: les données envoyé diffère suivant la ressource distante.

# Serveur
L'API répondra en JSON, sous la forme:
```json
{
	"code": 0,
	"data": {}
}
```
> Note:
> * **code**: (*int*) indique le code de résultat de l'appel.
> * **data**: (*multi*) les données (optionnel).

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
	* /friends		: récupère la liste des amis de l'utilisateur actuellement connecté.
	* /friends/*[id-user]*	: test si l'utilisateur actuellement connecté est ami avec `[id-user]`.
		* 200:oui, 404: non.
* **POST** :
	* /friends/*[id-user]*	: créer une demande d'ami à `[id-user]`.
* **DELETE** :
	* /friends/*[id-user]*	: supprime la relations avec `[id-user]`.

## Collection: /user/
* **GET** :
	* /user/*[id-user]*	: liste les méta-données de l'utilisateur `[id-user]`.
		* 404: l'utilisateur `[id-user]` n'exist pas.
	* /user/me :
		* liste les méta-données de l'utilisateur actuellement connecté.
		* si la session existe, alors: 200, sinon: 404.
* **POST** :
	* /user/		: connecte l'utilisateur.
	* /user/create/	: créer un utilisateur.
* **PUT** :
	* /user/		: met à jour les données de l'utilisateur actuellement connecté.
* **DELETE** :
	* /user/		: supprime l'utilisateur actuellement connecté.

## Collection: /position/
* **GET** :
	* /position/				: récupère les positions de l'utilisateur actuellement connecté.
	* /position/friends			: récupère les positions des amis de l'utilisateur actuellement connecté.
	* /position/friends/*[n]*	: pagination à la position `[n]`.
	* /position/*[id-user]*		: récupère la position de l'utilisateur `[id-user]`.
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

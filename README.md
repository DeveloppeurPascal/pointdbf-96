# Composant Password en Delphi (magazine PointDBF n°96)

Sources liés à l'article "[Composant Password en Delphi](https://developpeur-pascal.fr/composant-password-en-delphi-dans-le-magazine-pointdbf-96-janvier-1999.html)" publié dans le magazine *PointDBF* n°96 en janvier 1999.

Ce dépôt contient un composant Delphi VCL de connexion et de saisie de mot de passe. Il devrait toujours fonctionner en versions récentes de l'IDE de Delphi comme avec les versions historiques de l'environnement de développement.

Notez cependant que le référencement de ce composant, tel qu'il était fait à l'époque, nécessite des ajustements afin de ne pas le proposer à des projets non VCL (par exemple FireMonkey). Il faudrait faire évoluer les codes sources si on voulait adapter le programme et l'utiliser dans un projet récent.

L'[article publié à l'époque est consultable](https://developpeur-pascal.fr/composant-password-en-delphi-dans-le-magazine-pointdbf-96-janvier-1999.html) sur le blog [Developpeur Pascal](https://developpeur-pascal.fr/) avec les autres [publications](Publications).

## Codes sources dans le dossier /src

* "PP__PasswordDlg.dpk" correspond au paquet à compiler et installer dans l'IDE pour référencer le composant *TPPPasswordDlg* dans la palette.
* "TestPasswordDlgForm.dpr" permet de tester en direct la fenêtre utilisée par le composant
* "tst_comp.dpr" est un projet de test du composant qui doit avoir été référencé dans l'IDE avant de l'ouvrir et le compiler.

## Captures d'écran dans le dossier /screen-captures

![capture écran de connexion](https://github.com/DeveloppeurPascal/pointdbf-96/raw/main/screen-captures/se-connecter.jpg)

"se-connecter.jpg" montre la fenêtre de connexion (user/password) proposée par le composant en mode pduConnect

![capture écran modification mot de passe](https://github.com/DeveloppeurPascal/pointdbf-96/raw/main/screen-captures/modifier-mot-de-passe.jpg)

"modifier-mot-de-passe.jpg" montre la boite de dialogue en mode pduConnectAndChange pour saisir le user/password et changer le mot de passe avec saisie du nouveau mot de passe deux fois.

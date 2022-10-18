import 'package:flutter/material.dart';
import 'package:flutter_awale/awale.dart';

class AwalePage extends StatefulWidget {
  const AwalePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AwalePage> createState() => _AwalePageState();
}

class _AwalePageState extends State<AwalePage> {
  Awale jeu = Awale();
  //List<ElevatedButton> listeBoutton = [];

  /*
   * Methode qui remet par default l'affichage du jeu initialisé
   */
  restart() {
    jeu.initJeu();

    setState(() {});
  }

  /*
   * Methode qui execute les methodes liée au fonctionnement du jeu
   * pour savoir le bouton sur lequel nous avons cliqué,
   * nous récupérons l'indice placé en paramètre, qui correspond à l'indice du plateau
   */
  void actionDuJeu(int trou) {
    if (!jeu.testFin()) {
      if ((jeu.determineJoueur() == 0) && ((trou >= 0) && (trou <= 5))) {
        corpsDuJeu(trou);
      } else if ((jeu.determineJoueur() == 1) &&
          ((trou >= 6) && (trou <= 11))) {
        corpsDuJeu(trou);
      } else {
        // ajouter la snackbar manquante
        // cette dernière doit afficher la chaine de caractère
        // "Ce n'est pas votre coté joueurX" ou X est le numéro du joueur
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: getStringJoueur(),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(jeu.msgFinJeu()),
      ));
    }
  }

  Widget getStringJoueur() {
    String texte = "";
    if (jeu.determineJoueur() == 0) {
      texte = "Ce n'est pas votre coté joueur 2";
    } else {
      texte = "Ce n'est pas votre coté joueur 1";
    }
    return Text(texte);
  }

  /* Methode qui donne le corps du jeu (déplacement des graines et modification des tours)
   * et permet la mise a jours de l'interface
   * @param trou
   */
  void corpsDuJeu(int trou) {
    setState(() {
      if (jeu.getGraine(trou) != 0) {
        // zone à finir
        jeu.deplacerGraine(trou);
        jeu.tour++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("La case est vide !"),
        ));
      }
    });
  }

  /* 
   * Methode qui permet la construction de l'IHM du plateau de jeu
   */
  Widget plateauBuilder(Awale jeu) {
    Column grille = Column(
      children: [],
    );

    grille.children.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [Text('Coté joueur 1'), Text('Coté joueur 2')],
    ));

    for (int i = 0; i < 6; i++) {
      grille.children.add(ligneBuilder(i));
    }
    grille.children.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [Text('Score joueur 1:'), Text('Score joueur 2:')],
    ));
    grille.children.add(Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [Text('${jeu.score1}'), Text('${jeu.score2}')],
    ));
    return grille;
  }

  /* 
   * Methode qui permet de créer le lignes du plateau, comprenant 
   * un bouton pour chaque joueur (gauche joueur1, droite joueur2)
   */
  Widget ligneBuilder(int indice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.1,
          width: MediaQuery.of(context).size.width * 0.5,
          child: boutonBuilder(indice),
        ),
        Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.5,
            child: boutonBuilder(11 - indice)),
      ],
    );
  }

  /* 
   * Methode qui permet de créer les cases/boutons du plateau
   * selon sont coté, via l'indice.
   */
  Widget boutonBuilder(int indice) {
    ElevatedButton caseAwale = ElevatedButton(
      onPressed: () {
        actionDuJeu(indice);
      },
      child: Text(
        "${jeu.plateau[indice]}",
        style: const TextStyle(color: Colors.white, fontSize: 25),
      ),
      style: colorSide(indice),
    );

    return caseAwale;
  }

  /* 
   * Methode qui permet de determiner la couleur d'une case,
   * selon sont coté, via l'indice.
   */
  ButtonStyle colorSide(indice) {
    ButtonStyle bs;
    if (indice > 5) {
      bs = ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => Colors.brown.shade700));
    } else {
      bs = ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => Colors.brown.shade400));
    }
    return bs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            plateauBuilder(jeu),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: restart,
        tooltip: 'restart',
        child: const Icon(
          Icons.restart_alt,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

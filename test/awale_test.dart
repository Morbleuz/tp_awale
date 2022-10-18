// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_awale/awale.dart';

void main() {
  // TEST POUR AWALE.DART
  group("GetGraine", () {
    Awale jeu = Awale();
    test("- test avec case 0 à 4", () {
      expect(jeu.getGraine(0), 4);
    });
    test("- test avec case 0 à 0", () {
      jeu.plateau[0] = 0;
      expect(jeu.getGraine(0), 0);
    });
  });

  group("SetGraine", () {
    Awale jeu = Awale();
    test("- Mettre 0 dans la case 0", () {
      jeu.setGraine(0, 0);
      expect(jeu.getGraine(0), 0);
    });
  });

  group("initJeu", () {
    Awale jeu = Awale();
    jeu.score1 = 10;
    jeu.score2 = 4;
    jeu.tour = 0;
    jeu.plateau[0] = 1;
    jeu.plateau[2] = 2;
    jeu.plateau[11] = 8;
    jeu.initJeu();
    test("- Remet les scores et nbtour à 0", () {
      expect(jeu.score1, 0);
      expect(jeu.score2, 0);
      expect(jeu.tour, 0);
    });
    test("- Remet le plateau à 0", () {
      expect(jeu.plateau[0], 4);
      expect(jeu.plateau[2], 4);
      expect(jeu.plateau[11], 4);
    });
  });

  group("TestFin", () {
    Awale jeu = Awale();
    test("- Test score1=20", () {
      jeu.score1 = 20;
      expect(jeu.testFin(), true);
    });
    test("- Test score1=19", () {
      jeu.score1 = 19;
      expect(jeu.testFin(), false);
    });
    test("- Test score2=22", () {
      jeu.score2 = 22;
      expect(jeu.testFin(), true);
    });
  });

  group("ramasserGraine", () {
    Awale jeu = Awale();
    test("- rammaser graine trou 0 à 4", () {
      expect(jeu.ramasserGraine(0), 4);
    });
    test("- rammaser graine trou 11 à 8", () {
      jeu.plateau[11] = 8;
      expect(jeu.ramasserGraine(11), 8);
    });
  });

  group("deplacerGraine", () {
    Awale jeu = Awale();
    test("- deplacer trou 2", () {
      jeu.deplacerGraine(2);
      expect(jeu.plateau[2], 0);
      expect(jeu.plateau[6], 5);
    });
    test("- deplacer trou 11", () {
      jeu.deplacerGraine(11);
      expect(jeu.plateau[11], 0);
      expect(jeu.plateau[0], 5);
      expect(jeu.plateau[3], 6);
    });
  });
}

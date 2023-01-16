Start: Cls
Screen 12
Randomize Timer

Dim Champ(308321)
Dim Tank(576)
Dim Tank2(576)
Dim boom1(900)
Dim boom2(812)
Dim boom3(728)
Dim boom4(648)
Dim boom5(572)

'varaible
'haut = Int(Rnd * 5) + 2
'angle = Int(Rnd * 64) * 10
'zoom = (Int(Rnd * 5) + 1) * 5

ground = 2
cadre = 8
grille = 10
xtank = 10: ytank = 250: laser = 0
xtank2 = 620: ytank2 = 250: laser2 = 15
joueur = 1
max = 6
limit = 500
haut = max
angle = 320
start = 32
zoom = 15
zoom2 = 3
rayon = 5 'marge toucher cible

0 Cls
'Espace
Line (0, 0)-(640, 480), cadre, B
'Line (1, 1)-(639, 196), 0, BF
For etoile = 0 To 198
    PSet (Int(Rnd * 638) + 1, Int(Rnd * 196) + 1), Int(Rnd * 3) + 7
Next etoile

'Montagne
jj = Int(Rnd * 76) + 120
jjjj = Int(Rnd * 12) + 4
For j = 0 To 640 - (640 / (jjjj)) Step (640 / (jjjj - 1))
    jjj = Int(Rnd * 76) + 120
    Line (j, jj)-(j + (640 / (jjjj - 1)), jjj), cadre
    jj = jjj
Next j

Paint (320, 195), cadre, cadre
For roche = 0 To 2000
    rochex = Int(Rnd * 638) + 1
    rochey = Int(Rnd * 120) + 120
    If Point(rochex, rochey) = cadre And Point(rochex - 1, rochey) = cadre Then Circle (rochex, rochey), 2, 2
Next roche

'Grille
Line (1, 196 + start)-(639, 480), ground, BF

'Textur
For textur = 0 To 100000
    PSet (Int(Rnd * 638) + 1, Int(Rnd * 250) + 230), 6
Next textur

For i = -limit To limit Step zoom
    Line (i + angle, 196 + start)-((i * haut) + angle, 479), grille
Next i

'Cartographe
coord$ = "": pt = 0
iii = 0
ii = start + iii
For i = 196 + start To 480
    For iiii = 1 To 640
        If Point(iiii, ii + 196) = grille Then
            If Int(iiii) = lastx + 1 Then
                pt = pt
            Else
                PSet (iiii, ii + 196), grille + 8
                'coord$ = coord$ + LTrim$(Str$(Int(iiii))) + "," + LTrim$(Str$(Int(ii + 196))) + ";"
                pt = pt + 1
            End If
            lastx = Int(iiii)
        Else
            PSet (iiii, ii + 196), grille
        End If
    Next iiii
    ii = ii + ii / zoom2
Next i

GoSub tank
GoSub tank2
'Locate 1, 1: Print joueur

Do
    a$ = InKey$

    If a$ = Chr$(27) Then
        Color ground
        Locate 7, 20: Print "B a t t l e G r o u n d"
        Color grille
        Locate 9, 15: Print "OPTIONS"
        Locate 10, 15: Print "Esc) Retour to BattleGround"
        Locate 11, 15: Print "A) COULEURS TANK 1,2"
        Locate 12, 15: Print "Z) COULEURS TERRAIN"
        Color ground
        Locate 14, 15: Print "TOUCHES:"
        Locate 15, 15: Print "Espace) Reload Horizon"
        Locate 16, 15: Print "Arrows) Move Player 2"
        Locate 17, 15: Print "W/A/S/D) Move Player 1"
        Locate 18, 15: Print "Enter) Select Coordonner"
        Locate 19, 15: Print "Enter+Enter) Random Coordonner"
        Do
            a$ = InKey$
            If a$ = Chr$(27) Then GoTo 0
            If a$ = "a" Then Locate 11, 36: Input "Color [0-15], [0,15] > ", laser, laser2
            If a$ = "z" Then Locate 12, 36: Input "Color [0-15], [0-15] > ", ground, grille
        Loop
    End If

    If a$ = " " Then GoTo 0

    If joueur = 1 Then 'MKPH
        If a$ = "d" And xtank < 620 Then
            Line (xtank - 10, ytank - 10)-(xtank + 10, ytank + 10), 0, BF
            Put (xtank - 10, ytank - 10), Tank(), Or
            xtank = xtank + 1
            canon = 10
            GoSub tank
        End If
        If a$ = "a" And xtank > 10 Then
            Line (xtank - 10, ytank - 10)-(xtank + 10, ytank + 10), 0, BF
            Put (xtank - 10, ytank - 10), Tank(), Or
            xtank = xtank - 1
            canon = -10
            GoSub tank
        End If
        If a$ = "s" And ytank < 470 Then
            Line (xtank - 10, ytank - 10)-(xtank + 10, ytank + 10), 0, BF
            Put (xtank - 10, ytank - 10), Tank(), Or
            ytank = ytank + 1
            canon = 0
            GoSub tank
        End If
        If a$ = "w" And ytank > 230 Then
            Line (xtank - 10, ytank - 10)-(xtank + 10, ytank + 10), 0, BF
            Put (xtank - 10, ytank - 10), Tank(), Or
            ytank = ytank - 1
            canon = 0
            GoSub tank
        End If
    Else
        'Joueur2
        If a$ = Chr$(0) + "M" And xtank2 < 620 Then
            Line (xtank2 - 10, ytank2 - 10)-(xtank2 + 10, ytank2 + 10), 0, BF
            Put (xtank2 - 10, ytank2 - 10), Tank2(), Or
            xtank2 = xtank2 + 1
            canon2 = 10
            GoSub tank2
        End If
        If a$ = Chr$(0) + "K" And xtank2 > 10 Then
            Line (xtank2 - 10, ytank2 - 10)-(xtank2 + 10, ytank2 + 10), 0, BF
            Put (xtank2 - 10, ytank2 - 10), Tank2(), Or
            xtank2 = xtank2 - 1
            canon2 = -10
            GoSub tank2
        End If
        If a$ = Chr$(0) + "P" And ytank2 < 470 Then
            Line (xtank2 - 10, ytank2 - 10)-(xtank2 + 10, ytank2 + 10), 0, BF
            Put (xtank2 - 10, ytank2 - 10), Tank2(), Or
            ytank2 = ytank2 + 1
            canon2 = 0
            GoSub tank2
        End If
        If a$ = Chr$(0) + "H" And ytank2 > 230 Then
            Line (xtank2 - 10, ytank2 - 10)-(xtank2 + 10, ytank2 + 10), 0, BF
            Put (xtank2 - 10, ytank2 - 10), Tank2(), Or
            ytank2 = ytank2 - 1
            canon2 = 0
            GoSub tank2
        End If
    End If

    'Set Cordonner Tire
    If a$ = Chr$(13) Then
        Get (1, 1)-(639, 479), Champ()
        GoSub jet: GoSub Boom
        If joueur = 2 Then joueur = 1: GoTo 3
        If joueur = 1 Then joueur = 2: GoTo 3
        3 'Sleep
    End If

Loop

Accidenter:
x = 0: y = 0: cible$ = "": last = 0
For Xx = 1 To Len(coord$)
    If Mid$(coord$, Xx, 1) = ";" Then
        If last = 0 Then
            cible$ = Mid$(coord$, last, Xx)
            Print cible$

            cible$ = Mid$(coord$, Xx + 1, 7)
            If Mid$(cible$, Len(cible$), 1) = ";" Then cible$ = Mid$(cible$, 1, Len(cible$) - 1)
            Print cible$

            last = Xx + 1
            Sleep
        Else
            cible$ = Mid$(coord$, Xx + 1, 7)
            If Mid$(cible$, Len(cible$), 1) = ";" Then cible$ = Mid$(cible$, 1, Len(cible$) - 1)
            Print cible$

            last = Xx + 1
            Sleep
        End If
    End If
Next Xx
Return

Boom:
'etape 1
If xboom >= 15 And yboom >= 15 And xboom <= 625 And yboom <= 465 Then
    Get (xboom - 15, yboom - 15)-(xboom + 14, yboom + 14), boom1()
    Line (xboom - 15, yboom - 14)-(xboom + 14, yboom + 14), 0, BF
    Put (xboom - 15, yboom - 14), boom1(), Or
    'etape 2
    Get (xboom - 14, yboom - 14)-(xboom + 13, yboom + 13), boom2()
    Line (xboom - 14, yboom - 13)-(xboom + 13, yboom + 13), 0, BF
    Put (xboom - 14, yboom - 13), boom2(), Or
    'etape 3
    Get (xboom - 13, yboom - 13)-(xboom + 12, yboom + 12), boom3()
    Line (xboom - 13, yboom - 12)-(xboom + 12, yboom + 12), 0, BF
    Put (xboom - 13, yboom - 12), boom3(), Or
    'etape 4
    Get (xboom - 12, yboom - 12)-(xboom + 11, yboom + 11), boom4()
    Line (xboom - 12, yboom - 11)-(xboom + 11, yboom + 11), 0, BF
    Put (xboom - 12, yboom - 11), boom4(), Or
    'etape 5
    Get (xboom - 11, yboom - 11)-(xboom + 10, yboom + 10), boom5()
    Line (xboom - 11, yboom - 10)-(xboom + 10, yboom + 10), 0, BF
    Put (xboom - 11, yboom - 10), boom5(), Or
End If
Return

Parabole:
For xparabole = x + 1 To xlancer
    _Limit (10)

    yparabole = 2 * (xparabole * xparabole) + xparabole - 1

    ysprite = yparabole
    xsprite = xparabole
    Circle (ysprite + 3, xsprite + 7), 3, 14
    Paint (ysprite + 3, xsprite + 7), 6, 14

Next xparabole
Sleep
Return

jet:
'xjet2 = ((xz - 1) * 8) + 3: yjet2 = ((yz + 2) * 16) + 7

If joueur = 2 Then
    xjet = xtank2 + 10: yjet = ytank2 - 10
    xjoueur2 = Int(xtank2 / 8) + 1
    yjoueur2 = Int(ytank2 / 16) + 2
    Locate yjoueur2, xjoueur2: Print "J2"
Else
    xjet = xtank + 10: yjet = ytank - 10
    xjoueur = Int(xtank / 8) + 1
    yjoueur = Int(ytank / 16) + 2
    Locate yjoueur, xjoueur: Print "J1"
End If

CIBLE = 7
Locate 1, 1: Input "lancer x,y >", xjet2, yjet2
If xjet2 = 0 And yjet2 = 0 Then
    xjet2 = Int(Rnd * 620) + 10
    yjet2 = Int(Rnd * 460) + 10
End If

If xjet2 >= xtank Then
    canon = 1
Else
    canon = -1
End If
Line (xtank - 10, ytank - 10)-(xtank + 10, ytank + 10), 0, BF
Put (xtank - 10, ytank - 10), Tank(), Or
GoSub tank

If xjet2 >= xtank2 Then
    canon2 = 1
Else
    canon2 = -1
End If
Line (xtank2 - 10, ytank2 - 10)-(xtank2 + 10, ytank2 + 10), 0, BF
Put (xtank2 - 10, ytank2 - 10), Tank2(), Or
GoSub tank2

If xjet <= xjet2 Then
    bouclejet = 1
    ajet = 1 / (xjet2 - xjet)
    hjet = xjet + (xjet2 - xjet) / 2
Else
    bouclejet = -1
    ajet = 1 / (xjet - xjet2)
    hjet = xjet - (xjet - xjet2) / 2
End If

vjet = yjet - 1 / (yjet2 - yjet)
pjet = (yjet2 - yjet) / (xjet2 - xjet)

'Line (xjet, yjet)-(xjet2, yjet2), 13
If ((ajet * (-xjet + hjet) ^ 2 + vjet) + ((pjet * xjet) + (ajet * (-((xjet2 - xjet) / 2) + (xjet + (xjet2 - xjet) / 2)) ^ 2 + (yjet - 1 / (yjet2 - yjet)))) - yjet) > yjet Then
    trajetjet = yjet - ((ajet * (-xjet + hjet) ^ 2 + vjet) + ((pjet * xjet) + (ajet * (-((xjet2 - xjet) / 2) + (xjet + (xjet2 - xjet) / 2)) ^ 2 + (yjet - 1 / (yjet2 - yjet)))) - yjet)
End If
If ((ajet * (-xjet + hjet) ^ 2 + vjet) + ((pjet * xjet) + (ajet * (-((xjet2 - xjet) / 2) + (xjet + (xjet2 - xjet) / 2)) ^ 2 + (yjet - 1 / (yjet2 - yjet)))) - yjet) < yjet Then
    trajetjet = ((ajet * (-xjet + hjet) ^ 2 + vjet) + ((pjet * xjet) + (ajet * (-((xjet2 - xjet) / 2) + (xjet + (xjet2 - xjet) / 2)) ^ 2 + (yjet - 1 / (yjet2 - yjet)))) - yjet) - yjet
End If

If (ajet * (-xjet + hjet) ^ 2 + vjet) > yjet Then
    ombrejet = yjet - (ajet * (-xjet + hjet) ^ 2 + vjet)
End If
If (ajet * (-xjet + hjet) ^ 2 + vjet) < yjet Then
    ombrejet = (ajet * (-xjet + hjet) ^ 2 + vjet)
End If

For ijet = xjet To xjet2 Step (bouclejet)
    'Cls

    sjet = ajet * (-ijet + hjet) ^ 2 + vjet
    ysprite = ijet 'forme canonique
    xsprite = sjet
    Circle (ysprite, xsprite), 1, 8
    'Color 6: Locate 1, 1: Print xsprite, ysprite

    s2jet = (pjet * ijet) + (ajet * (-((xjet2 - xjet) / 2) + (xjet + (xjet2 - xjet) / 2)) ^ 2 + (yjet - 1 / (yjet2 - yjet)))
    ysprite = ijet 'ombre
    xsprite = s2jet - ombrejet + trajetjet
    Circle (ysprite, xsprite), 2, 0 '8
    Circle (ysprite, xsprite), 1, 0 '8
    'Color 7: Locate 2, 1: Print xsprite, ysprite

    ysprite = ijet 'trajectoir
    xsprite = sjet + s2jet - yjet + trajetjet
    Circle (ysprite, xsprite), 2, CIBLE
    Circle (ysprite, xsprite), 1, CIBLE
    'Color 6: Locate 2, 1: Print xsprite, ysprite

    _Limit (100) '72
    Line (1, 1)-(639, 479), 0, BF
    Put (1, 1), Champ(), Or
    'GoSub scope

    'Quand la bombe touche la cible
    If ijet = xjet2 Then
        For boomjet = 1 To 16 'Nombre d'explosion
            _Limit (32)
            boomxjet = Int(Rnd * 9) - 5
            boomyjet = Int(Rnd * 9) - 5
            Circle (xjet2 + boomxjet, yjet2 + boomyjet), 3, 14
            Paint (xjet2 + boomxjet, yjet2 + boomyjet), 6, 14
        Next boomjet

        'Effce l'explosion
        Line (1, 1)-(639, 479), 0, BF
        Put (1, 1), Champ(), Or

        'Game Over
        If (xjet2 < xtank + rayon And xjet2 >= xtank - rayon And yjet2 < ytank + rayon And yjet2 >= ytank - rayon) Then
            Locate 7, 15: Print "FIN DE LA PARTIE"
            Locate 8, 15: Print "Le Joueur 2 a Gagner."
            Sleep
            GoTo Start
        End If
        If (xjet2 < xtank2 + rayon And xjet2 >= xtank2 - rayon And yjet2 < ytank2 + rayon And yjet2 >= ytank2 - rayon) Then
            Locate 7, 15: Print "FIN DE LA PARTIE"
            Locate 8, 15: Print "Le Joueur 1 a Gagner."
            Sleep
            GoTo Start
        End If
    End If
Next ijet

xboom = xjet2
yboom = yjet2
Return

tank:
'Tank
Get (xtank - 10, ytank - 10)-(xtank + 10, ytank + 10), Tank()
For Tank = 1 To 8
    Circle (xtank, ytank), Tank, laser, 0, 3.14
    Circle (xtank + 1, ytank), Tank, laser, 0, 3.14
Next Tank
Line (xtank, ytank)-(xtank + canon, ytank - 10), laser
Return

tank2:
'Tank2
Get (xtank2 - 10, ytank2 - 10)-(xtank2 + 10, ytank2 + 10), Tank2()
For Tank = 1 To 8
    Circle (xtank2, ytank2), Tank, laser2, 0, 3.14
    Circle (xtank2 + 1, ytank2), Tank, laser2, 0, 3.14
Next Tank
Line (xtank2, ytank2)-(xtank2 + canon2, ytank2 - 10), laser2
Return

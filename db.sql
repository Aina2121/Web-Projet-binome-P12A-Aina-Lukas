CREATE ROLE rlukas login password "123456";
    CREATE DATABASE telephonie_mobile;
    ALTER DATABASE telephonie_mobile OWNER TO rlukas;


CREATE SEQUENCE type_offre_idtype_offre_seq;
CREATE TABLE Type_Offre (
                idType_Offre INTEGER NOT NULL DEFAULT nextval('type_offre_idtype_offre_seq'),
                type VARCHAR NOT NULL,
                CONSTRAINT idtype_offre PRIMARY KEY (idType_Offre)
);
ALTER SEQUENCE type_offre_idtype_offre_seq OWNED BY Type_Offre.idType_Offre;
INSERT INTO Type_Offre(type) VALUES ('Appel');
INSERT INTO Type_Offre(type) VALUES ('SMS');
INSERT INTO Type_Offre(type) VALUES ('Internet');

CREATE TABLE Mode_Achat (
                idMode_Achat INTEGER NOT NULL,
                mode VARCHAR NOT NULL,
                CONSTRAINT idmode_achat PRIMARY KEY (idMode_Achat)
);
INSERT INTO Mode_Achat(idMode_Achat, mode) VALUES (1, 'Credit');
INSERT INTO Mode_Achat(idMode_Achat, mode) VALUES (2, 'Mobile Money');


CREATE SEQUENCE administrateur_idadministrateur_seq;
CREATE TABLE Administrateur (
                idAdministrateur INTEGER NOT NULL DEFAULT nextval('administrateur_idadministrateur_seq'),
                nom_administrateur VARCHAR NOT NULL,
                mot_de_passe VARCHAR NOT NULL,
                CONSTRAINT idadministrateur PRIMARY KEY (idAdministrateur)
);
ALTER SEQUENCE administrateur_idadministrateur_seq OWNED BY Administrateur.idAdministrateur;
INSERT INTO Administrateur(nom_administrateur, mot_de_passe) VALUES ('root', md5('root'));

CREATE TABLE Type_Mouvement (
                idTypeMouvement INTEGER NOT NULL,
                type VARCHAR NOT NULL,
                CONSTRAINT idtypemouvement PRIMARY KEY (idTypeMouvement)
);
INSERT INTO Type_Mouvement VALUES (1, 'ENTRANT');
INSERT INTO Type_Mouvement VALUES (2, 'SORTANT');

CREATE SEQUENCE utilisateur_idutilisateur_seq;
CREATE TABLE Utilisateur (
                idUtilisateur INTEGER NOT NULL DEFAULT nextval('utilisateur_idutilisateur_seq'),
                nom_utilisateur VARCHAR NOT NULL,
                mot_de_passe VARCHAR NOT NULL,
                numero VARCHAR NOT NULL,
                CONSTRAINT idutilisateur PRIMARY KEY (idUtilisateur)
);
ALTER SEQUENCE utilisateur_idutilisateur_seq OWNED BY Utilisateur.idUtilisateur;
INSERT INTO Utilisateur (idUtilisateur, nom_utilisateur, mot_de_passe, numero) VALUES (nextval('utilisateur_idutilisateur_seq'), 'Neymar Jr',md5('neymarjunior'), '0358794100');

CREATE SEQUENCE compte_credit_idcomptecredit_seq;
CREATE TABLE Compte_Credit (
                idCompteCredit INTEGER NOT NULL DEFAULT nextval('compte_credit_idcomptecredit_seq'),
                idUtilisateur INTEGER NOT NULL,
                idTypeMouvement INTEGER NOT NULL,
                montant DOUBLE PRECISION NOT NULL,
                dateCompte DATE NOT NULL,
                CONSTRAINT idcomptecredit PRIMARY KEY (idCompteCredit)
);
ALTER SEQUENCE compte_credit_idcomptecredit_seq OWNED BY Compte_Credit.idCompteCredit;

CREATE SEQUENCE depot_en_attente_iddepotenattente_seq;
CREATE TABLE Depot_En_Attente (
                idDepotEnAttente INTEGER NOT NULL DEFAULT nextval('depot_en_attente_iddepotenattente_seq'),
                montant DOUBLE PRECISION NOT NULL,
                idUtilisateur INTEGER NOT NULL,
                CONSTRAINT iddepotenattente PRIMARY KEY (idDepotEnAttente)
);
ALTER SEQUENCE depot_en_attente_iddepotenattente_seq OWNED BY Depot_En_Attente.idDepotEnAttente;

CREATE SEQUENCE authentification_idauthentification_seq;
CREATE TABLE Authentification (
                idAuthentification INTEGER NOT NULL DEFAULT nextval('authentification_idauthentification_seq'),
                idUtilisateur INTEGER NOT NULL,
                token VARCHAR NOT NULL,
                CONSTRAINT idauthentification PRIMARY KEY (idAuthentification)
);
ALTER SEQUENCE authentification_idauthentification_seq OWNED BY Authentification.idAuthentification;

CREATE SEQUENCE compte_mobile_money_idcomptemmoney_seq;
CREATE TABLE Compte_Mobile_Money (
                idCompteMMoney INTEGER NOT NULL DEFAULT nextval('compte_mobile_money_idcomptemmoney_seq'),
                idUtilisateur INTEGER NOT NULL,
                idTypeMouvement INTEGER NOT NULL,
                montant DOUBLE PRECISION NOT NULL,
                dateCompte DATE NOT NULL,
                idDepotEnAttente INTEGER NOT NULL,
                CONSTRAINT idcomptemmoney PRIMARY KEY (idCompteMMoney)
);
ALTER SEQUENCE compte_mobile_money_idcomptemmoney_seq OWNED BY Compte_Mobile_Money.idCompteMMoney;

CREATE SEQUENCE operateur_idoperateur_seq;
CREATE TABLE Operateur (
                idOperateur INTEGER NOT NULL DEFAULT nextval('operateur_idoperateur_seq'),
                nom_operateur VARCHAR NOT NULL,
                prefixe VARCHAR NOT NULL,
                rapport_duree_appel INTEGER NOT NULL,
                CONSTRAINT idoperateur PRIMARY KEY (idOperateur)
);
ALTER SEQUENCE operateur_idoperateur_seq OWNED BY Operateur.idOperateur;
INSERT INTO Operateur(nom_operateur, prefixe, rapport_duree_appel) VALUES ('GASYTEL', '035', 1);
INSERT INTO Operateur(nom_operateur, prefixe, rapport_duree_appel) VALUES ('ORANGE', '032', 3);
INSERT INTO Operateur(nom_operateur, prefixe, rapport_duree_appel) VALUES ('TELMA', '034', 2);
INSERT INTO Operateur(nom_operateur, prefixe, rapport_duree_appel) VALUES ('AIRTEL', '033', 4);


CREATE SEQUENCE appel_idappel_seq;
CREATE TABLE Appel (
                idAppel INTEGER NOT NULL DEFAULT nextval('appel_idappel_seq'),
                idUtilisateur INTEGER NOT NULL,
                idOperateur INTEGER NOT NULL,
                numero VARCHAR NOT NULL,
                duree INTEGER NOT NULL,
                dateAppel DATE NOT NULL,
                CONSTRAINT idappel PRIMARY KEY (idAppel)
);
ALTER SEQUENCE appel_idappel_seq OWNED BY Appel.idAppel;

CREATE SEQUENCE offre_idoffre_seq;
CREATE TABLE Offre (
                idOffre INTEGER NOT NULL DEFAULT nextval('offre_idoffre_seq'),
                nom_offre VARCHAR NOT NULL,
                prix_offre DOUBLE PRECISION NOT NULL,
                CONSTRAINT idoffre PRIMARY KEY (idOffre)
);
ALTER SEQUENCE offre_idoffre_seq OWNED BY Offre.idOffre;
INSERT INTO Offre(nom_offre, prix_offre) VALUES ('TSY LAFO 200', 200.0);
INSERT INTO Offre(nom_offre, prix_offre) VALUES ('TSY LAFO 500', 500.0);
INSERT INTO Offre(nom_offre, prix_offre) VALUES ('TSY LAFO 1000', 1000.0);
INSERT INTO Offre(nom_offre, prix_offre) VALUES ('TSY LAFO NIGHT', 400.0);
INSERT INTO Offre(nom_offre, prix_offre) VALUES ('SURFEO', 500.0);

CREATE SEQUENCE offre_type_offre_idoffre_type_offre_seq;
CREATE TABLE Offre_Type_Offre (
                idOffre_Type_Offre INTEGER NOT NULL DEFAULT nextval('offre_type_offre_idoffre_type_offre_seq'),
                idOffre INTEGER NOT NULL,
                idType_Offre INTEGER NOT NULL,
                valeur_offre INTEGER NOT NULL,
                CONSTRAINT idoffre_type_offre PRIMARY KEY (idOffre_Type_Offre)
);
ALTER SEQUENCE offre_type_offre_idoffre_type_offre_seq OWNED BY Offre_Type_Offre.idOffre_Type_Offre;
INSERT INTO Offre_Type_Offre(idOffre, idType_Offre, valeur_offre) VALUES (1, 1, 10);
INSERT INTO Offre_Type_Offre(idOffre, idType_Offre, valeur_offre) VALUES (1, 2, 50);
INSERT INTO Offre_Type_Offre(idOffre, idType_Offre, valeur_offre) VALUES (2, 1, 60);
INSERT INTO Offre_Type_Offre(idOffre, idType_Offre, valeur_offre) VALUES (2, 2, 20);
INSERT INTO Offre_Type_Offre(idOffre, idType_Offre, valeur_offre) VALUES (2, 3, 10);
INSERT INTO Offre_Type_Offre(idOffre, idType_Offre, valeur_offre) VALUES (3, 1, 30);
INSERT INTO Offre_Type_Offre(idOffre, idType_Offre, valeur_offre) VALUES (3, 2, 30);
INSERT INTO Offre_Type_Offre(idOffre, idType_Offre, valeur_offre) VALUES (3, 3, 50);
INSERT INTO Offre_Type_Offre(idOffre, idType_Offre, valeur_offre) VALUES (4, 2, 50);
INSERT INTO Offre_Type_Offre(idOffre, idType_Offre, valeur_offre) VALUES (4, 3, 50);
INSERT INTO Offre_Type_Offre(idOffre, idType_Offre, valeur_offre) VALUES (5, 3, 1000);
-- INSERT INTO Offre_Type_Offre(idOffre, idType_Offre, valeur_offre) VALUES (5, 3, 50);

CREATE SEQUENCE achat_offre_idachat_offre_seq;
CREATE TABLE Achat_offre (
                idAchat_offre INTEGER NOT NULL DEFAULT nextval('achat_offre_idachat_offre_seq'),
                idUtilisateur INTEGER NOT NULL,
                idOffre INTEGER NOT NULL,
                idMode_Achat INTEGER NOT NULL,
                CONSTRAINT idachat_offre PRIMARY KEY (idAchat_offre)
);
ALTER SEQUENCE achat_offre_idachat_offre_seq OWNED BY Achat_offre.idAchat_offre;

CREATE SEQUENCE consommation_idconsommation_seq;
CREATE TABLE Consommation (
                idConsommation INTEGER NOT NULL DEFAULT nextval('consommation_idconsommation_seq'),
                idUtilisateur INTEGER NOT NULL,
                idType_Offre INTEGER NOT NULL,
                consommation INTEGER NOT NULL,
                CONSTRAINT idconsommation PRIMARY KEY (idConsommation)
);
ALTER SEQUENCE consommation_idconsommation_seq OWNED BY Consommation.idConsommation;

ALTER TABLE Consommation ADD CONSTRAINT type_offre_consommation_fk
FOREIGN KEY (idType_Offre)
REFERENCES Type_Offre (idType_Offre)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Consommation ADD CONSTRAINT utilisateur_consommation_fk
FOREIGN KEY (idUtilisateur)
REFERENCES Utilisateur (idUtilisateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Offre_Type_Offre ADD CONSTRAINT type_offre_offre_type_offre_fk
FOREIGN KEY (idType_Offre)
REFERENCES Type_Offre (idType_Offre)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Achat_offre ADD CONSTRAINT mode_achat_achat_offre_fk
FOREIGN KEY (idMode_Achat)
REFERENCES Mode_Achat (idMode_Achat)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Compte_Mobile_Money ADD CONSTRAINT type_mouvement_compte_mobile_money_fk
FOREIGN KEY (idTypeMouvement)
REFERENCES Type_Mouvement (idTypeMouvement)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Compte_Credit ADD CONSTRAINT type_mouvement_compte_credit_fk
FOREIGN KEY (idTypeMouvement)
REFERENCES Type_Mouvement (idTypeMouvement)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Appel ADD CONSTRAINT utilisateur_appel_fk
FOREIGN KEY (idUtilisateur)
REFERENCES Utilisateur (idUtilisateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Compte_Mobile_Money ADD CONSTRAINT utilisateur_compte_mobile_money_fk
FOREIGN KEY (idUtilisateur)
REFERENCES Utilisateur (idUtilisateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Authentification ADD CONSTRAINT utilisateur_authentification_fk
FOREIGN KEY (idUtilisateur)
REFERENCES Utilisateur (idUtilisateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Depot_En_Attente ADD CONSTRAINT utilisateur_depot_en_attente_fk
FOREIGN KEY (idUtilisateur)
REFERENCES Utilisateur (idUtilisateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Achat_offre ADD CONSTRAINT utilisateur_achat_offre_fk
FOREIGN KEY (idUtilisateur)
REFERENCES Utilisateur (idUtilisateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Compte_Credit ADD CONSTRAINT utilisateur_compte_credit_fk
FOREIGN KEY (idUtilisateur)
REFERENCES Utilisateur (idUtilisateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Appel ADD CONSTRAINT operateur_appel_fk
FOREIGN KEY (idOperateur)
REFERENCES Operateur (idOperateur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Achat_offre ADD CONSTRAINT offre_achat_offre_fk
FOREIGN KEY (idOffre)
REFERENCES Offre (idOffre)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE Offre_Type_Offre ADD CONSTRAINT offre_offre_type_offre_fk
FOREIGN KEY (idOffre)
REFERENCES Offre (idOffre)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- //Resaka Compte MOBILE MONEY
CREATE OR REPLACE VIEW Compte AS SELECT Compte_Mobile_Money.idCompteMMoney,
Compte_Mobile_Money.idUtilisateur, Utilisateur.nom_utilisateur, 
Compte_Mobile_Money.idTypeMouvement, Compte_Mobile_Money.montant, Compte_Mobile_Money.dateCompte
FROM Compte_Mobile_Money JOIN Utilisateur on Compte_Mobile_Money.idUtilisateur = Utilisateur.idUtilisateur;

CREATE OR REPLACE VIEW Entrant AS SELECT Compte.idUtilisateur, sum(montant) as entrant FROM Compte WHERE idTypeMouvement = 1 GROUP BY idUtilisateur;

CREATE OR REPLACE VIEW Sortant AS SELECT Compte.idUtilisateur, sum(montant) as sortant FROM Compte WHERE idTypeMouvement = 2 GROUP BY idUtilisateur;

CREATE OR REPLACE VIEW MontantEnCompte AS SELECT Entrant.idUtilisateur, Entrant.entrant - Sortant.sortant as montant 
FROM Entrant JOIN Sortant ON Entrant.idUtilisateur = Sortant.idUtilisateur;

CREATE OR REPLACE VIEW MontantEnCompteUtilisateur AS SELECT Utilisateur.numero, Utilisateur.nom_utilisateur, MontantEnCompte.*
FROM MontantEnCompte JOIN Utilisateur on MontantEnCompte.idUtilisateur = Utilisateur.idUtilisateur;

-- //Resaka Compte Credit
CREATE OR REPLACE VIEW CompteCredit AS SELECT Compte_Credit.idCompteCredit,
Compte_Credit.idUtilisateur, Utilisateur.nom_utilisateur, 
Compte_Credit.idTypeMouvement, Compte_Credit.montant, Compte_Credit.dateCompte
FROM Compte_Credit JOIN Utilisateur on Compte_Credit.idUtilisateur = Utilisateur.idUtilisateur;

CREATE OR REPLACE VIEW EntrantCredit AS SELECT CompteCredit.idUtilisateur, sum(montant) as entrant FROM CompteCredit WHERE idTypeMouvement = 1 GROUP BY idUtilisateur;

CREATE OR REPLACE VIEW SortantCredit AS SELECT CompteCredit.idUtilisateur, sum(montant) as sortant FROM CompteCredit WHERE idTypeMouvement = 2 GROUP BY idUtilisateur;

CREATE OR REPLACE VIEW MontantEnCompteCredit AS SELECT EntrantCredit.idUtilisateur, EntrantCredit.entrant - SortantCredit.sortant as montant 
FROM EntrantCredit JOIN SortantCredit ON EntrantCredit.idUtilisateur = SortantCredit.idUtilisateur;

CREATE OR REPLACE VIEW MontantEnCompteUtilisateurCredit AS SELECT Utilisateur.numero, Utilisateur.nom_utilisateur, MontantEnCompteCredit.*
FROM MontantEnCompteCredit JOIN Utilisateur on MontantEnCompteCredit.idUtilisateur = Utilisateur.idUtilisateur;

-- //Resaka Offre sy Type Offre
CREATE OR REPLACE VIEW DetailsOffre AS SELECT Offre.*, Type_Offre.idType_Offre ,Type_Offre.type, Offre_Type_Offre.valeur_offre FROM Offre_Type_Offre JOIN Offre ON
Offre_Type_Offre.idOffre = Offre.idOffre JOIN Type_Offre ON Offre_Type_Offre.idType_Offre = Type_Offre.idType_Offre;

-- //Resaka Offre
CREATE OR REPLACE VIEW AchatOffreDetails AS SELECT Achat_offre.*, DetailsOffre.nom_offre, DetailsOffre.prix_offre,
DetailsOffre.idType_Offre, DetailsOffre.type, DetailsOffre.valeur_offre
FROM Achat_offre JOIN DetailsOffre on Achat_offre.idOffre = DetailsOffre.idOffre;

-- //Transaction achat offre 
CREATE OR REPLACE FUNCTION achatoffre()
    RETURNS TRIGGER AS
$$
DECLARE montant DOUBLE PRECISION;
DECLARE idU INTEGER;
DECLARE idMA INTEGER;
BEGIN
        SELECT prix_offre into montant from AchatOffreDetails where idAchat_offre = NEW.idAchat_offre;
        SELECT idUtilisateur into idU from AchatOffreDetails where idAchat_offre = NEW.idAchat_offre;
        SELECT idMode_Achat into idMA from AchatOffreDetails where idAchat_offre = NEW.idAchat_offre;
        IF idMA = 1 THEN INSERT INTO Compte_Credit(idUtilisateur,idTypeMouvement,montant, dateCompte) VALUES(idU, 2, montant, CURRENT_DATE); END IF; 
        IF idMA = 2 THEN INSERT INTO Compte_Mobile_Money(idUtilisateur,idTypeMouvement,montant, dateCompte, idDepotEnAttente) VALUES(idU, 2, montant, CURRENT_DATE, 0); END IF;  

    RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER achatoffre_trigger
    AFTER INSERT ON Achat_offre
    FOR EACH ROW
    EXECUTE PROCEDURE achatoffre();

-- //Transaction validation
CREATE OR REPLACE FUNCTION valider()
    RETURNS TRIGGER AS
$$
DECLARE idDEA INTEGER;
BEGIN
        SELECT idDepotEnAttente into idDEA from Compte_Mobile_Money where idDepotEnAttente = NEW.idDepotEnAttente;
        DELETE FROM Depot_En_Attente WHERE idDepotEnAttente = idDEA;
    RETURN NEW;
END;
$$
LANGUAGE 'plpgsql';

CREATE TRIGGER validation_trigger
    AFTER INSERT ON Compte_Mobile_Money
    FOR EACH ROW
    EXECUTE PROCEDURE valider();

-- //Resaka duree total offre
SELECT sum(duree_appel) as dureeTotal from AchatOffreDetails where idUtilisateur = 1 GROUP BY idUtilisateur;

-- //Resaka depot en attente
CREATE OR REPLACE VIEW Depot_En_Attente_Utilisateur AS SELECT Depot_En_Attente.*, 
Utilisateur.nom_utilisateur,Utilisateur.numero FROM Depot_En_Attente
JOIN Utilisateur ON Depot_En_Attente.idUtilisateur = Utilisateur.idUtilisateur;


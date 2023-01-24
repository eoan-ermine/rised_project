-- "addons\\rised_character_system\\lua\\character_creator\\sh_chc_lang.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
 _____ _                          _                   _____                _             
/  __ \ |                        | |                 /  __ \              | |            
| /  \/ |__   __ _ _ __ __ _  ___| |_ ___ _ __ ______| /  \/_ __ ___  __ _| |_ ___  _ __ 
| |   | '_ \ / _` | '__/ _` |/ __| __/ _ \ '__|______| |   | '__/ _ \/ _` | __/ _ \| '__|
| \__/\ | | | (_| | | | (_| | (__| ||  __/ |         | \__/\ | |  __/ (_| | || (_) | |   
|_____/_| |_|\__,_|_|  \__,_|\___|\__\___|_|          \____/_|  \___|\__,_|\__\___/|_|   
  
                                                                                         
]]           

-----------------------------------------------------------------------------
--------------------------Langage Configuration------------------------------
-----------------------------------------------------------------------------

include("sh_chc_config.lua")

Configuration_Chc_Lang = {}

Configuration_Chc_Lang[1] = {
    ["pl"] = "WYJDŹ",
    ["fr"] = "QUITTER",
    ["en"] = "LEAVE",
    ["es"] = "SALIR",
    ["ru"] = "ВЫЙТИ",
    ["de"] = "VERLASSEN"
}

Configuration_Chc_Lang[2] = {
    ["pl"] = "Pieniądze",
    ["fr"] = "Argent",
    ["en"] = "Money",
    ["es"] = "Dinero",
    ["ru"] = "Начальные деньги",
    ["de"] = "Geld"
}

Configuration_Chc_Lang[3] = {
    ["pl"] = "Praca",
    ["fr"] = "Profession",
    ["en"] = "Profession",
    ["es"] = "Profesión",
    ["ru"] = "Профессия",
    ["de"] = "Beruf"
}

Configuration_Chc_Lang[4] = {
    ["pl"] = "Narodowość",
    ["fr"] = "Nationalité",
    ["en"] = "Nationality",
    ["es"] = "Nacionalidad",
    ["ru"] = "Раса",
    ["de"] = "Nationalität"
}

Configuration_Chc_Lang[5] = {
    ["pl"] = "Płeć: Mężczyzna",
    ["fr"] = "Votre sexe : Homme",
    ["en"] = "Your sex : Male",
    ["es"] = "Tu sexo : Masculino",
    ["ru"] = "Пол : Мужской",
    ["de"] = "Dein Geschlecht: Männlich"
}

Configuration_Chc_Lang[6] = {
    ["pl"] = "Płeć: Kobieta",
    ["fr"] = "Votre sexe : Femme",
    ["en"] = "Your sex : Female",
    ["es"] = "Tu género : Femenino",
    ["ru"] = "Пол: Женский",
    ["de"] = "Dein Geschlecht: Weiblich"
}

Configuration_Chc_Lang[7] = {
    ["pl"] = "Imię gracza - Roleplay",
    ["fr"] = "Prenom-Roleplay",
    ["en"] = "First name-Roleplay",
    ["es"] = "Nombre de pila - Roleplay",
    ["ru"] = "Имя",
    ["de"] = "Vorname - Roleplay"
}

Configuration_Chc_Lang[8] = {
    ["pl"] = "Nazwisko gracza - Roleplay",
    ["fr"] = "Nom-Roleplay",
    ["en"] = "Name-Roleplay",
    ["es"] = "Nombre-Roleplay",
    ["ru"] = "Фамилия",
    ["de"] = "Nachname - Roleplay"
}

Configuration_Chc_Lang[9] = {
    ["pl"] = "STWÓRZ",
    ["fr"] = "CREER",
    ["en"] = "CREATE",
    ["es"] = "CREAR",
    ["ru"] = "СОЗДАТЬ",
    ["de"] = "ERSTELLEN"
}

Configuration_Chc_Lang[10] = {
    ["pl"] = "WRÓĆ",
    ["fr"] = "RETOUR",
    ["en"] = "BACK",
    ["es"] = "RETORNO",
    ["ru"] = "ВЕРНУТСЯ",
    ["de"] = "ZURÜCK"
}

Configuration_Chc_Lang[11] = {
    ["pl"] = "Kobieta",
    ["fr"] = "Feminin",
    ["en"] = "Female",
    ["es"] = "Femenino",
    ["ru"] = "Женский",
    ["de"] = "Weiblich"
}

Configuration_Chc_Lang[12] = {
    ["pl"] = "Mężczyzna",
    ["fr"] = "Masculin",
    ["en"] = "Male",
    ["es"] = "Masculino",
    ["ru"] = "Мужской",
    ["de"] = "Männlich"
}

Configuration_Chc_Lang[13] = {
    ["pl"] = "Stwórz postać",
    ["fr"] = "Créer un personnage",
    ["en"] = "Create a character",
    ["es"] = "Crear personaje",
    ["ru"] = "Создать персонажа",
    ["de"] = "Charakter erstellen"
}

Configuration_Chc_Lang[14] = {
    ["pl"] = "Witamy na",
    ["fr"] = "Bienvenue sur",
    ["en"] = "Welcome to",
    ["es"] = "Bienvenido a",
    ["ru"] = "Добро пожаловать на",
    ["de"] = "Willkommen auf "
}

Configuration_Chc_Lang[15] = {
    ["pl"] = "Witamy na serwerze, Obywatelu",
    ["fr"] = "Bienvenue sur le Serveur Citoyen",
    ["en"] = "Welcome to the Server Citizen",
    ["es"] = "Bienvenido ciudadano al servidor",
    ["ru"] = "Добро пожаловать на сервер",
    ["de"] = "Willkommen auf dem Server, Einwohner."
}

Configuration_Chc_Lang[16] = {
    ["pl"] = "ROZPOCZNIJ SWOJĄ PRZYGODĘ",
    ["fr"] = "COMMENCER L'AVENTURE",
    ["en"] = "GETTING STARTED",
    ["es"] = "EMPEZADO",
    ["ru"] = "НАЧНЁМ",
    ["de"] = "ERSTE SCHRITTE"
}

Configuration_Chc_Lang[17] = {
    ["pl"] = "STWÓRZ SWOJĄ POSTAĆ",
    ["fr"] = "CREER VOTRE PERSONNAGE",
    ["en"] = "CREATE YOUR CHARACTER",
    ["es"] = "CREA TU PERSONAJE",
    ["ru"] = "СОЗДАЙТЕ СВОЕГО ПЕРСОНАЖА",
    ["de"] = "ERSTELLE DEINEN CHARAKTER"
}

Configuration_Chc_Lang[18] = {
    ["pl"] = "Tutaj możesz stworzyć swoją postać",
    ["fr"] = "Ici vous pouvez créer votre personnage",
    ["en"] = "Here you can create your character",
    ["es"] = "Aquí puedes crear tu personaje",
    ["ru"] = "Здесь вы можете создать своего персонажа",
    ["de"] = "Hier können Sie Ihren Charakter erstellen"
}

Configuration_Chc_Lang[19] = {
    ["pl"] = "Twoja postać została zapisana!",
    ["fr"] = "Votre personnage viens d'être sauvegardé !",
    ["en"] = "Your character has been saved!",
    ["es"] = "¡Tu personaje fue salvado!",
    ["ru"] = "Ваш персонаж был сохранен!",
    ["de"] = "Dein Charakter wurde gespeichert!"
}

Configuration_Chc_Lang[20] = {
    ["pl"] = "Usuwanie postaci",
    ["fr"] = "Suppression de personnage",
    ["en"] = "Character deletion",
    ["es"] = "Borrar caracteres",
    ["ru"] = "Удаление персонажа",
    ["de"] = "Character löschen."
}

Configuration_Chc_Lang[21] = {
    ["pl"] = "Charakter",
    ["fr"] = "Personnage",
    ["en"] = "Character",
    ["es"] = "Carácter",
    ["ru"] = "Персонаж",
    ["de"] = "Charakter"
}

Configuration_Chc_Lang[22] = {
    ["pl"] = "Usuwanie postaci",
    ["fr"] = "Destruction du personnage",
    ["en"] = "Character destruction",
    ["es"] = "Destrucción de personajes",
    ["ru"] = "Уничтожение персонажа",
    ["de"] = "Character löschen"
}

Configuration_Chc_Lang[23] = {
    ["pl"] = "Akceptuj",
    ["fr"] = "Accepter",
    ["en"] = "Accept",
    ["es"] = "Aceptar",
    ["ru"] = "Принять",
    ["de"] = "Akzeptieren"
}

Configuration_Chc_Lang[24] = {
    ["pl"] = "Anuluj",
    ["fr"] = "Annuler",
    ["en"] = "Cancel",
    ["es"] = "Anulador",
    ["ru"] = "Отмена",
    ["de"] = "Abbrechen"
}

Configuration_Chc_Lang[25] = {
    ["pl"] = "GRAJ",
    ["fr"] = "JOUER",
    ["en"] = "PLAY",
    ["es"] = "JUEGO",
    ["ru"] = "ИГРАТЬ",
    ["de"] = "SPIELEN"
}

Configuration_Chc_Lang[26] = {
    ["pl"] = "POTWIERDŹ",
    ["fr"] = "CONFIRMER",
    ["en"] = "CONFIRM",
    ["es"] = "CONFIRMAR",
    ["ru"] = "ПРИНЯТЬ",
    ["de"] = "BESTÄTIGEN"
}

Configuration_Chc_Lang[27] = {
    ["pl"] = "Usuń",
    ["fr"] = "Supprimer",
    ["en"] = "Delete",
    ["es"] = "Borrar",
    ["ru"] = "Удалить",
    ["de"] = "Löschen"
}

Configuration_Chc_Lang[28] = {
    ["pl"] = "Aktualizuj",
    ["fr"] = "Update",
    ["en"] = "Update",
    ["es"] = "Actualizar",
    ["ru"] = "Обновить",
    ["de"] = "Aktualisieren"
}

Configuration_Chc_Lang[29] = {
    ["pl"] = "Praca :",
    ["fr"] = "Profession :",
    ["en"] = "Profession :",
    ["es"] = "Profesión :",
    ["ru"] = "Профессия :",
    ["de"] = "Beruf :"
}

Configuration_Chc_Lang[30] = {
    ["pl"] = "Wybierz postać",
    ["fr"] = "Choisir le Personnage",
    ["en"] = "Choose the Character",
    ["es"] = "Elige el Caracter",
    ["ru"] = "ВЫБЕРИТЕ ПЕРСОНАЖА",
    ["de"] = "CHARAKTER WÄHLEN"
}

Configuration_Chc_Lang[31] = {
    ["pl"] = "Brak danych",
    ["fr"] = "Aucune Data Trouvée",
    ["en"] = "No Data Found",
    ["es"] = "Datos no encontrados",
    ["ru"] = "Данные не найдены",
    ["de"] = "Keine Daten gefunden"
}

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
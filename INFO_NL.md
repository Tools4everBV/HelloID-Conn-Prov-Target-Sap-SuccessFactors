Met behulp van de SAP Target & Source Connector koppel je SAP via de Identity & Access Management (IAM)-oplossing HelloID van Tools4ever als doelsysteem koppelen aan je bronsystemen. Ook maakt de connector het uitlezen van SAP HCM als bronsysteem mogelijk. De integratie automatiseert identity management-processen en neemt je veel werk uit handen. In dit artikel gaan we in op deze connector, de mogelijkheden en de voordelen.   

## Wat is SAP

SAP ontwikkelt software voor het beheer van bedrijfsprocessen. De oplossingen ondersteunen dataverwerking en informatiestromen tussen organisaties. SAP biedt onder meer software voor Enterprise Resource Planning (ERP), Supply Chain Management (SCP) en Customer Relationship Management (CRM) aan, maar ook oplossingen voor financieel beheer en Human Capital Management (HCM). De applicaties zijn met elkaar geïntegreerd in een suite, die wordt aangeboden via een online digitaal platform. 


## Waarom is SAP koppeling handig?

Klanten gebruiken SAP vaak als een centraal systeem in hun organisatie. In veel gevallen zijn bedrijfsprocessen dan ook sterk afhankelijk van SAP. Als platform kent SAP vele verschillende vormen. Zo is SAP HCM een HRM-systeem dat als bronsysteem dienst kan doen. Tegelijkertijd is SAP ook als onder meer ERP- SCP- of CRM-systeem beschikbaar, waarmee HelloID als doelsysteem kan communiceren. De wijze waarop HelloID met SAP koppelt is dan ook afhankelijk van de SAP-oplossing die je gebruikt. 

Wie bijvoorbeeld met SAP als ERP-, SCP- of CRM-systeem aan de slag wil heeft hiervoor een account nodig. Dankzij de koppeling tussen je bronsysteem en SAP via HelloID heb je geen omkijken naar het beheer hiervan. HelloID neemt het proces volledig uit handen en hiermee veel complexiteit weg. Zo hoef je niet langer handmatig accounts aan te maken, voorkom je via automatisering menselijke fouten en heb je geen omkijken naar het beheer van toegangsrechten. Wijzigen gegevens in je bronsysteem? Dan merkt HelloID dit automatisch op en past indien nodig SAP-accounts hierop aan. 

Gebruik je SAP HCM als bronsysteem? Dan zorgt de SAP-connector dat SAP HCM naadloos integreert met je doelsystemen. HelloID kan in dit geval op basis van gegevens uit SAP HCM de benodigde accounts aanmaken en beheren in je doelsystemen, en neemt daarnaast ook het beheer van autorisaties voor rekening.  

De SAP-connector maakt integraties met allerlei veelvoorkomende systemen mogelijk. Enkele voorbeelden zijn:

*	Active Directory

*	Entra ID (voorheen Azure AD)

Verderop in dit artikel lees je meer over deze integraties.

## Hoe HelloID integreert met SAP

SAP koppelt primair als doelsysteem met HelloID. De SAP-connector vormt daarbij in veel gevallen een aanvulling op de Active Directory en/of Entra ID-connector. In veel gevallen gebruikt de connector dan ook accountgegevens die afkomstig zijn van een andere doelconnector. De connector is echter ook inzetbaar als bronconnector, waarbij het SAP HCM als bronsysteem koppelt aan je doelsystemen. 

HelloID spreekt via de SAP-connector de Business Application Programming Interfaces (BAPI’s) en remote-enabled functiemodules binnen een SAP-oplossing aan. Deze API’s en modules maken niet alleen het beheer van accounts en autorisaties in bijvoorbeeld SAP R/3 en R/4 HANA mogelijk, maar ook het uitlezen van informatie uit SAP HCM.

**Gebruikersaccounts beheren**
De koppeling stelt HelloID onder meer in staat tot het beheren van gebruikersaccounts in SAP. Zo kan de IAM-oplossing accounts aanmaken, en daarbij onder meer de gebruikersnaam, voor- en achternaam, adresgegevens en referentiegebruiker instellen. Ook kan HelloID specifieke gebruikersprofielen toewijzen aan SAP-accounts. Wijzigen de gegevens van een gebruiker in je bronsysteem? Dan past HelloID het bijbehorende SAP-account hierop automatisch aan. Treedt een medewerker uit dienst? Dan kan HelloID het account van de gebruikers automatisch verwijderen. 

**Op maat gemaakte commando’s uitvoeren**
HelloID kan via de SAP-connector ook een BAPI-call doen. Dit maakt het onder meer het uitvoeren mogelijk van op maat gemaakte commando’s die de klant zelf heeft toegevoegd aan het SAP-systeem. 

Voor het verbinden van de SAP-connector met de gewenste SAP-oplossing is de juiste configuratie noodzakelijk. Het configureren van de connector vindt plaats via de SAP Connector for Microsoft .NET. Deze integratiemogelijkheid zorgt dat de SAP-connector zich kan gedragen als een SAP-client, en zo verbinding kan maken met een SAP-systeem. Voor de configuratie zijn de volgende properties nodig: NAME, ASHOST, SYSID, SYSNR, CLIENT, USER en PASSWD.

## HelloID voor SAP helpt je met

* **Accounts efficiënter aanmaken:** HelloID detecteert wijzigingen in je bronsysteem, zoals het aanmaken van een nieuwe gebruiker, het wijzigen van gegevens of juist het aflopen van het dienstverband van een medewerker. Op basis hiervan voert de IAM-oplossing automatisch de juiste handeling uit. Zo kan HelloID automatisch een SAP-account aanmaken, gegevens van een account wijzigen of een account juist verwijderen. Dit zorgt voor een efficiënter beheer van gebruikersaccounts en zorgt dat nieuwe medewerkers direct aan de slag kunnen. 

* **Complexiteit wegnemen:** De koppeling tussen je bronsystemen en SAP-systemen of juist de koppeling tussen SAP HCM en je doelsystemen neemt veel complexiteit weg. Zo is het werken met losse scripts niet langer nodig en zorgt de SAP-connector voor een uniforme werkwijze. 

* **Foutloos accountbeheer:** Menselijke fouten bij het beheer van accounts behoren dankzij de koppeling tussen SAP en HelloID tot het verleden. Zo zorgt de IAM-oplossing dat accounts altijd de juiste rechten toegekend krijgen, zodat medewerkers direct aan de slag kunnen en productief kunnen zijn. 

* **Accountbeheer koppelen aan het IDU-proces:** Het beheer van gebruikersaccounts is dankzij de koppeling tussen SAP en HelloID altijd gekoppeld aan je instroom-, doorstroom- en uitstroomproces (IDU-proces). Wijzigt de functie van een medewerker? Dan past HelloID de toegangsrechten automatisch hierop aan. Stroomt een medewerker uit? Dan trekt HelloID automatisch uitgedeelde toegangsrechten in en verwijdert indien nodig accounts. Prettig, want zo weet je zeker dat ongeautoriseerde gebruikers niet onbedoeld toegang behouden tot systemen en til je zowel je serviceniveau als beveiliging naar een hoger niveau.

## SAP via HelloID koppelen met systemen

Je kunt via HelloID diverse systemen koppelen aan SAP, en zo het beheer van gebruikersaccounts en autorisaties verbeteren. Enkele voorbeelden van veelvoorkomende integraties zijn: 

* **Microsoft Active Directory - SAP koppeling:** De Microsoft Active Directory - SAP koppeling zorgt dat HelloID mutaties in Active Directory automatisch kan verwerken, waarbij het bronsysteem altijd leidend is. Zo kan HelloID een nieuwe gebruiker aanmaken, toegangsrechten wijzigen of een account juist verwijderen. Zo weet je zeker dat SAP-accounts altijd in lijn zijn met Active Directory.

* **Microsoft Entra ID - SAP koppeling:** De Microsoft Entra ID – SAP koppeling neemt je veel werk uit handen bij up-to-date houden van accounts en gebruikersrechten in SAP. HelloID detecteert automatisch wijzigingen in Entra ID, en voert deze op consistente wijze door in SAP. Zo heb je geen omkijken naar het beheer hiervan. 

HelloID biedt ondersteuning voor meer dan 200 connectoren. Je kunt de IAM-oplossing van Tools4ever dan ook aan nagenoeg alle populaire bron- en doelsystemen koppelen. Benieuwd naar de connectoren die we aanbieden? <a href="https://www.tools4ever.nl/connectoren/">Bekijk</a> het volledige overzicht op onze website.

# Registre TXT

L'enregistrement « texte » (TXT) du DNS permet à l'administrateur du domaine de saisir du texte dans le DNS (Domain Name System). À l'origine, l'enregistrement TXT était destiné à accueillir des notes lisibles par l'homme. Cependant, il est désormais possible de placer des données lisibles par machine dans les enregistrements TXT. Un domaine peut avoir plusieurs enregistrements TXT.

### Quel type de données peut être contenu dans un enregistrement TXT ?

La RFC originale indique seulement que les « chaînes de texte » doivent être placées dans le champ « valeur » d'un enregistrement TXT. Il peut s'agir de n'importe quel texte qu'un administrateur souhaite associer à son domaine.

La plupart des serveurs DNS imposent une limite à la taille des enregistrements TXT et au nombre d'enregistrements qu'ils peuvent stocker. Les administrateurs ne peuvent donc pas utiliser les enregistrements TXT pour de grandes quantités de données.

### Comment les enregistrements TXT aident-ils à prévenir les spams ?

Les spammeurs essaient souvent de falsifier ou de contrefaire les domaines à partir desquels ils envoient leurs messages électroniques. Les enregistrements TXT sont un élément clé de plusieurs méthodes d'authentification du courrier électronique qui aident un serveur de messagerie à déterminer si un message provient d'une source fiable.

Les méthodes courantes d'authentification du courrier électronique sont DKIM (Domain Keys Identified Mail), SPF (Sender Policy Framework) et DMARC (Domain-based Message Authentication, Reporting & Conformance). En configurant ces enregistrements, les opérateurs de domaines peuvent rendre plus difficile pour les spammeurs l'usurpation de leurs domaines et peuvent suivre les tentatives d'usurpation.

Enregistrements SPF: Les enregistrements SPF TXT répertorient tous les serveurs autorisés à envoyer des messages électroniques à partir d'un domaine.

Enregistrements DKIM : DKIM fonctionne en signant numériquement chaque courriel à l'aide d'une paire de clés publique-privée. Cela permet de vérifier que l'e-mail provient bien du domaine qu'il prétend être. La clé publique est hébergée dans un enregistrement TXT associé au domaine.

Enregistrements DMARC: Un enregistrement TXT DMARC fait référence aux politiques SPF et DKIM du domaine. Il doit être stocké sous le titre _dmarc.exemple.com. avec 'exemple.com' remplacé par le nom de domaine réel. La « valeur » de l'enregistrement est la politique DMARC du domaine.

## Source :

- [Guide : cloudflare TXT](https://www.cloudflare.com/fr-fr/learning/dns/dns-records/dns-txt-record/)
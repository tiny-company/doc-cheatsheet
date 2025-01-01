# Registre DKIM


DomainKeys Identified Mail (DKIM) is a method of email authentication that helps prevent spammers and other malicious parties from impersonating a legitimate domain.

All email addresses have a domain — the part of the address after the "@" symbol. Spammers and attackers may try to impersonate a domain when sending emails to carry out phishing attacks or other scams.

Suppose Chuck wants to trick Alice, who works for example.com, into sending him confidential company information. He could send her an email that seems to be coming from "bob@example.com" to fool her into thinking he also works for example.com.

DKIM, along with Sender Policy Framework (SPF) and Domain-based Message Authentication Reporting and Conformance (DMARC), makes it much more difficult for attackers to impersonate domains in this way. Emails that do not pass DKIM and SPF get marked as "spam" or are not delivered by email servers. If example.com has DKIM, SPF, and DMARC set up for their domain, then Alice will probably never even see Chuck's malicious email because it will either go to her spam folder or be rejected by the email server altogether.


## Source :

- [Guide Cloudlfare DKIM](https://www.cloudflare.com/learning/dns/dns-records/dns-dkim-record/)
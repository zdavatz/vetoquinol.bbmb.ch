#!/usr/bin/env ruby
# Html::Util::Lookandfeel -- bbmb.ch -- 15.09.2006 -- hwyss@ywesee.com

require 'sbsm/lookandfeel'

module BBMB
  module Html
    module Util
class Lookandfeel < SBSM::Lookandfeel
  DICTIONARIES = {
    "de"  =>  {
      :additional_info          =>  "Zusatzinformationen",
      :address1                 =>  "Adresse",
      :backorder                =>  "im Rückstand",
      :barcode_button           =>  "Barcode-Leser",
      :barcode_empty            =>  "Es sind keine Barcodes im Leser.",
      :barcode_none             =>  "Es konnte keine Verbindung zum Barcode-Leser hergestellt werden.",
      :barcode_usb              =>  "Download USB-Treiber",
      :barcode_wait             =>  "Einen Moment, bitte...",
      :canton                   =>  "Kanton",
      :change_pass              =>  "Passwort ändern",
      :clear_favorites          =>  "Schnellb. löschen",
      :clear_favorites_confirm  =>  "Wollen Sie wirklich die gesamte Schnellbestellung löschen?",
      :clear_order              =>  "Bestellung löschen",
      :clear_order_confirm      =>  "Wollen Sie wirklich die gesamte Bestellung löschen?",
      :cleartext                =>  "Passwort",
      :city                     =>  "Ort",
      :comment                  =>  "Bemerkungen (max. 60 Zeichen)",
      :commit                   =>  "Bestellung auslösen",
      :confirm_pass             =>  "Bestätigung",
      :contact                  =>  "Kontaktperson",
      :currency                 =>  "Sfr.",
      :currency_format          =>  "Sfr. %.2f",
      :current_order            =>  "Home",
      :customer                 =>  "Kunde",
      :customers                =>  "Kunden",
      :customer_id              =>  "Kundennr",
      :delete                   =>  "Löschen",
      :default_values           =>  "Voreinstellungen",
      :drtitle                  =>  "Titel",
      :ean13                    =>  "EAN-Code",
      :email                    =>  "Email",
      :error                    =>  "Ihre Eingaben konnten nicht gespeichert werden da Angaben fehlen oder nicht korrekt sind.\nBitte ergänzen Sie die rot gekennzeichneten Felder.",
      :e_duplicate_email        =>  "Es gibt bereits ein Benutzerprofil für diese Email-Adresse",
      :e_email_required         =>  "Bitte speichern Sie zuerst eine gültige Email-Adresse",
      :e_empty_pass             =>  "Das Passwort war leer.",
      :e_invalid_ean13          =>  "Der EAN-Code war ungültig.",
      :e_non_matching_pass      =>  "Das Passwort und die Bestätigung waren nicht identisch.",
      :e_pass_not_set           =>  "Das Passwort konnte nicht gespeichert werden",
      :e_user_unsaved           =>  "Das Benutzerprofil wurde nicht gespeichert!",
      :false                    =>  "Nein",
      :favorites                =>  "Schnellbestellung",
      :favorite_positions0      =>  "Aktuelle Schnellbest.: ",
      :favorite_positions1      =>  " Positionen",
      :favorite_product         =>  "Zu Schnellbest. hinzufügen",
      :favorite_transfer        =>  "Datei zu Schnellb.",
      :fax                      =>  "Fax",
      :filter_button            =>  "Filter",
      :firstname                =>  "Vorname",
      :generate_pass            =>  "Passwort Generieren",
      :history                  =>  "Umsatz",
      :history_turnover0        =>  "Totalumsatz: ",
      :history_turnover1        =>  "",
      :html_title               =>  "BBMB",
      :increment_order          =>  "Zu Best. hinzufügen",
      :lastname                 =>  "Name",
      :lgpl                     =>  "LGPL",
      :list_price0              =>  '',
      :list_price1              =>  ' Stk. à ',
      :list_price2              =>  '',
      :logged_in_as0            =>  "Sie sind angemeldet als ",
      :logged_in_as1            =>  "",
      :login                    =>  "Anmelden",
      :logout                   =>  "Abmelden",
      :logo                     =>  "Vétoquinol",
      :new_customer             =>  "Neuer Kunde",
      :new_customer_mail        =>  "mailto:info@vetoquinol.ch?subject=Neukunde BBMB - bitte Passwort generieren",
      :new_customer_invite      =>  "Bestellen Sie jetzt online. Wir richten für Sie den spezifisch auf Ihre Praxis zugeschnittenen, benutzerfreundlichen E-Shop ein!\nUnser Kundenservice oder unsere Aussendienstmitarbeiter beraten Sie gerne!",
      :next                     =>  ">>",
      :nullify                  =>  "Alles auf 0 setzen",
      :order                    =>  "Archiv - Bestellung",
      :orders                   =>  "Archiv",
      :order_problem            =>  <<-EOS,
Beim Versand Ihrer Bestellung ist ein Problem aufgetreten.
Ein Administrator wurde automatisch darüber informiert und wird mit Ihnen Kontakt aufnehmen.
      EOS
      :order_product            =>  "Zu Bestellung hinzufügen",
      :order_sent               =>  "Ihre Bestellung wurde an die Vétoquinol AG versandt.",
      :order_total              =>  "Total Sfr. ",
      :order_transfer           =>  "Datei zu Best.",
      :organisation             =>  "Kunde",
      :pass                     =>  "Passwort",
      :pager_index0             =>  " ",
      :pager_index1             =>  " bis ",
      :pager_index2             =>  " ",
      :pager_total0             =>  " von ",
      :pager_total1             =>  "",
      :pcode                    =>  "Pharmacode",
      :phone_business           =>  "Tel. Geschäft",
      :phone_mobile             =>  "Tel. Mobile",
      :phone_private            =>  "Tel. Privat",
      :plz                      =>  "PLZ",
      :positions0               =>  "Aktuelle Bestellung: ",
      :positions1               =>  " Positionen",
      :previous                 =>  "<<",
      :price_range0             =>  "",
      :price_range1             =>  " bis ",
      :price_range2             =>  "",
      :priority                 =>  "Versandart",
      :priority_0               =>  "Nichts Ausw&auml;hlen",
      :priority_1               =>  "Post",
      :priority_13              =>  "Express Mond",
      :priority_16              =>  "Express Freitag",
      :priority_21              =>  "Kurier",
      :priority_40              =>  "Terminfracht",
      :priority_41              =>  "Terminfracht",
      :priority_explain_1       =>  "Lieferung n&auml;chster Tag (gem. Konditionenliste)",
      :priority_explain_13      =>  "Lieferung Vormittag n&auml;chster Tag (z.L. Kunde)",
      :priority_explain_16      =>  "Lieferung am Samstag (z.L. Kunde)",
      :priority_explain_21      =>  "Lieferung am gleichen Tag (z.L. Kunde)",
      :priority_explain_40      =>  "bis 09:00 Uhr / 80 Sfr. (z.L. Kunde)",
      :priority_explain_41      =>  "bis 10:00 Uhr / 50 Sfr. (z.L. Kunde)",
      :product_found            =>  "Suchresultat: 1 Produkt gefunden",
      :products_found0          =>  "Suchresultat: ",
      :products_found1          =>  " Produkte gefunden",
      :reference                =>  "Interne Bestellnummer",
      :reset                    =>  "Zurücksetzen",
      :save                     =>  "Speichern",
      :search                   =>  "Suchen",
      :search_favorites         =>  "Suchen",
      :show_pass                =>  "Passwort Anzeigen",
      :th_city                  =>  "Ort",
      :th_commit_time           =>  "Bestellung vom",
      :th_customer_id           =>  "Kundennr",
      :th_description           =>  "Artikelbezeichnung",
      :th_email                 =>  "Email",
      :th_item_count            =>  "Packungen",
      :th_last_login            =>  "Letztes Login",
      :th_order_count           =>  "Best.",
      :th_price                 =>  "Preis",
      :th_price_base            =>  "Preis",
      :th_price_levels          =>  'Staffelpreise',
      :th_quantity              =>  'Menge', 
      :th_order_total           =>  "Endpreis",
      :th_organisation          =>  "Kunde",
      :th_plz                   =>  "PLZ",
      :th_size                  =>  "Positionen",
      :th_total                 =>  "Total",
      :th_valid                 =>  "Aktiviert",
      :title                    =>  "Anrede",
      :title_f                  =>  "Frau",
      :title_m                  =>  "Herr",
      :true                     =>  "Ja",
      :turnover                 =>  "Umsatz",
      :unavailable0             =>  "Unidentifiziertes Produkt (",
      :unavailable1             =>  ")",
      :version                  =>  "Commit-ID",
      :welcome                  =>  "Willkommen bei Vétoquinol",
      :ywesee                   =>  "ywesee.com",
    }
  }
  RESOURCES = {
    :activex    => 'activex',
    :css        => 'bbmb.css',
    :dojo_js    => 'dojo/dojo.js',
    :javascript => 'javascript',
    :logo       => 'logo.gif',
  }
  def navigation
    zone_navigation + super
  end
end
    end
  end
end

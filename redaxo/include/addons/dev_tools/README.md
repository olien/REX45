Dev-Tools AddOn für REDAXO 4
===================================

Durch dieses REDAXO-Addon werden alle Email-Adressen automatisch so verschleiert, dass sie von Spambots nicht mehr erkannt werden können. Momentan werden 2 Verschleierungs-Methoden zur Auswahl angeboten. Weitere sind geplant...

Features
--------

* Vollautomatisches Verschleiern der Email-Adressen mit bewährten Algorithmen
* Sowohl nackte als auch Email-Adressen in einem A-Tag werden berücksichtigt
* Mehrere Verschleierungs-Methoden zur Auswahl

Hinweise
--------

* Getestet mit REDAXO 4.4, 4.5
* Addon-Ordner lautet: `email_obfuscator`
* Die CSS Methode benötigt diesen Eintrag in Ihrem Stylesheet: `span.hide { display: none; }`
* AddOn-Name lautete früher `Protect My Email`

Changelog
---------

siehe [CHANGELOG.md](CHANGELOG.md)

Lizenz
------

siehe [LICENSE.md](LICENSE.md)

Credits
-------

* Danke an WordPress für die `make_clickable()` Funktion :)
* Danke an [Xong](https://github.com/xong) für die Hilfe zu RegEx

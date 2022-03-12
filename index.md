name: inverse
layout: true
class: left, middle, inverse

---

# Einführung in Go

Philipp Weißmann

## [mail@philipp-weissmann.de](mailto:mail@philipp-weissmann.de)

---

# Agenda

- Voraussetzungen
- Herkunft
- Eigenschaften & Philosophie
- Einsatzgebiete
- Vom Aufsetzen einer Umgebung
- Vom Kompilieren und Abhängigkeiten
- Von Variablen, Schleifen und Verzweigungen
- Channels & Nebenläufigkeit

---

# Voraussetzungen

- Wissen über Programmieren / Programmiersprachen
- Grundlagen Englisch;
- Betriebssystem: Beliebig
- Aus diesen Unterlagen per _copy & paste_ Code kopieren können
- Go Installation
- Editor:
  - [Go](https://golang.org/doc/install)
    - Der Befehl `go` muss auf der Kommandozeile zur Verfügung stehen
  - [Visual Studio Code](https://code.visualstudio.com/)
  - [Go Plugin](https://marketplace.visualstudio.com/items?itemName=golang.go)
  - [Code Runner Plugin](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner)
  - [Git](https://git-scm.com/)
    - Der Befehl `git` muss auf der Kommandozeile zur Verfügung stehen
    - Git muss HTTPS Quellen aus dem Internet erreichen können
- Profis:
  - Beliebiger Editor / Kommandozeilen-Nutzung
  - Installation via [asdf](https://github.com/asdf-vm/asdf) empfehlenswert

---

# Herkunft

- Name: _Go_ oder auch _Golang_ (Go Language)
- Google
- Unix Ursteine: Griesemer, Pike & Thompson
- Release: 2009, Stable: 2012
- Netzwerkumfeld

---

# Motivation

- C++ & Java: Ungeeignet für _skalierbare_ Netzwerkdienste / Cloud Computing
- C & C++: Ineffiziente Compiler
- Allgemein: Sprachen viel zu aufgeladen / komplex

---

# Eigenschaften 1

- Garbage Collector
- Kompiliert, extrem schneller Compiler
- Typsicher: stark & statisch
- Zeiger, aber keine Zeiger-Arithmetik
- Closures (anonyme Funktionen)
- Reflections (Programm kennt eigene Strukturen)

---

# Eigenschaften 2

- Objektorientierung? Interfaces & Mixins - keine Klassen
- Nebenläufigkeit: Easy as pie
  - Routinen
  - Channels
- Erst seit 1.18: Generics

---

# Getting started 1

- Das erste Programm
- Erstelle `hello.go`
- Inhalt:

```go
package main

import "fmt"

func main() {
	fmt.Println("Hello, 🦫")
}
```

- Kompilieren:
  - `go build hello.go`
  - `hello` bzw. `hello.exe` ensteht
  - Datei ausführen: `./hello` bzw `.\hello.exe`

---

# Getting started 2

- Direkt ausführen:

  - `go run hello.go`
  - Kein dauerhaftes Binary wird erzeugt

- Crosscompilieren:
  - `GOARCH=amd64 GOOS=linux go build hello.go` (bash)
  - `$env:GOARCH = 'amd64'; $env:GOOS = 'linux'; go build hello.go` (Powershell)
  - Ein Linux Binary für AMD64 Platform entsteht

---

# Getting started 3

- Bestandteile:

```go
package main
```

- "Modul" des Programms. `main`-Modul: Einstiegspunkt für Programm

```go
import "fmt"
```

- Lade Bibliothek `fmt`

---

# Getting started 4

- Bestandteile:

```go
func main() {
...
}
```

- Hauptroutine des Programms: `main` ist Einstiegspunkt des Programms.
- Ohne `main` Routine: Bibliothek

```go
	fmt.Println("Hello, 🦫")
```

- Benutze `fmt` Bibliothek
- Führe `Println` Funktion aus ebendieser aus
- Text: Unicode!

---

# Werkzeugkiste

- Go nutzt Formatierung _nicht_ für den Programmfluss (vgl. Python)
- Go bringt bereits Code Formatierer mit: `go fmt`
- z.B. `go fmt hello.go`
- Durch Plugins / Workflows oft integriert
- Einheitlicher Coding Style
- Tipp:
  - Spätestens vor dem Verwalten mit Git formatieren
  - Besser: Beim Speichern automatisch formatieren

---

# Funktionen 1

```go
package main

import "fmt"

func add(x int, y int) int {
	return x + y
}

func main() {
	fmt.Println(add(47, 11))
}
```

- Parameter-Deklaration
- Typdeklaration (hier: int)
- Achtung: Reihenfolge!

---

# Funktionen 2

```go
package main

import "fmt"

func swap(x, y string) (string, string) {
	return y, x
}

func main() {
	a, b := swap("hello", "world")
	fmt.Println(a, b)
}
```

Bemerkenswert:

- Mehre Parameter vom gleichen Typ `x, y string`
- Mehrere Rückgabewerte `(string, string)`: Typ, `return y,x`: Wert
- Mehrere Zuweisungen / _unzipping_ `a,b := ...`
- pascalCase

---

# Funktionen 3

```go
package main

import "fmt"

func split(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return
}

func main() {
	fmt.Println(split(17))
}
```

Bemerkenswert:

- Woher weiß `return`, welche Wert zurückgegeben werden soll?

---

# Vom Aufsetzen einer Umgebung

Vorraussetung: Installierte Software (siehe vorherige Folien)

Umgebungsvariablen:

- `GOROOT`: Hier wird Go gesucht
- `GOPATH`: Hier werden alle Bibliotheken, Binaries und Libraries abgelegt

---

# Benutzen einer Bibliothek 1

Normalerweise werden Biblitheken *global* abgelegt

Beispiel:
`go get github.com/derphilipp/helloworldgo`
Installiert die Bibliotheken nach
`GOPATH/src/github.com/derphilipp/helloworldgo`

Möchte man seine Quellen *im Projekt* ablegen, nutzt man "heute" ein *vendor* Verzeichnis

---

# Benutzen einer Bibliothek 2

Beispiel:

In neuem Verzeichnis
`go mod init github.com/derphilipp/myproject`

Legt ein `go.mod` Datei an:

```go
module github.com/derphilipp/myproject

go 1.17
```

Dies können wir durch weitere Module/Bibliotheken ergänzen:

`go get github.com/derphilipp/helloworldgo`

---

# Benutzen einer Bibliothek 3

Beispiel Programm:

```go
package main

import "github.com/derphilipp/helloworldgo"

func main() {
    helloworldgo.HelloWorld("Philipp")
}
```

Version und Abhängigkeit in `go.mod` und `go.sum` festgeschrieben.

Abhängigkeiten mit ablegen: `go mod vendor` -> Legt Verzeichnis mit Bibliotheken an

---

# Benutzen einer Bilbiothek - Fazit

- Verwenden von Bibliotheken aus Git Quellen
- Verwalten & Archivieren von externen Bilbiotheken spielend einfach mit `vendor`
- Kein extra Aufwand eigene Bibliotheken anzubieten, lediglich Quellzugriff ermöglichen
- Firmen-Interne Quellen auch Problemfrei möglich
- Tipp: Immer Vendor Versionen mit ablegen um zukünftige Verfügbarkeit zu Garantieren ([npm Fiasko](https://gimletmedia.com/shows/reply-all/xjhe54))

---

# Deklaration vs. Initialisierung

```go
package main

import "fmt"

var i, j int = 1, 2

func main() {
	var c, python, java = true, false, "no!"
	k := 3
	fmt.Println(i, j, k, c, python, java)
}
```

Bemerkenswert:

- `var`: Variable
- `int`: Typ
- `1`: Wert
- Welchen Typ haben `c, python, java`?
- `k := 3`
  - Variable, mit initialisiertem Wert und automatischer Typisierung
  - Nur in Funktion möglich

---

# Deklaration vs. Initialisierung Zusammenfassung

- Variable deklarieren mit `var` und Typenangabe
- Ohne Initialisierung: Default Wert
- Deklarieren & Initialisieren mit `:=`

# Variablen: Sichtbarkeit & Konventionen

- Sichtbarkeit:
  - Modul-Variablen mit kleinem ersten Buchstaben: Nur Intern erreichbar
  - Modul-Variablen mit großem ersten Buchstaben: Wird exportiert -> Auch extern extern erreichbar
  - Kein "private" Scope
- Namenskonvetionen:
  - Pascal oder camelCase
  - Akronyme Großschreiben (z.B. `HTTPS`, `SSH`)
  - Tipp: Lange Variablen für *langlebige* Inhalte

---

# Übung Deklaration

1. Erstelle ein kleines Programm
   - Lege eine globale Variable (ausserhalb `main`) an
   - Gebe deren Wert aus
2. Lege ein Variable in `main` an mit dem gleichen Namen an. Was passiert?
3. Lege die Variable erneut in `main` an. Was passiert?
4. Lösche die Ausgabe der Variable. Was passiert?

---

# Mehr Typen

```go
package main

import (
  "fmt"
  "math/cmplx"
)

var (
    ToBe bool = false
    MaxInt uint64 = i <<64-1 // (Linksshift)
    z complex128 = complex.Sqrt(-5 + 12i)
)

func main() {
  fmt.Printf("Type %T Value : %v\n", ToBe, ToBe)
  fmt.Printf("Type %T Value : %v\n", MaxInt, MaxInt)
  fmt.Printf("Type %T Value : %v\n", z, z)
}
```

- Eingebaute Typen (z.B. `bool`, `uint64`), aber auch aus Bibliotheken (`complex128`)
- Ausgabe des Typs via `%T`, des Werts via `%v`

---

# Übung: Typen

- Erstelle ein Programm mit möglichst vielen verschiedenen Variablen-Typen (z.B. `uint64`).
- Lege diese Variablen an, ohne sie zu initialisieren
- Welche Typen "findest" Du?
- Was passiert, wenn Du die Variablen nur deklarierst, aber ausgibst?

---

# Übung: Typen initialisieren

- Erstelle ein Programm mit möglichst vielen verschiedenen Initialisierungs-Werten
- Lege diese Variablen an, in dem Du sie einfach mit `:=` initialisierst
- Welche Typen "findest" Du und welchen Typ geben sie aus (`fmt.Printf("%T")`)

---

# Konvertieren

```go
package main

import (
	"fmt"
	"strconv"
)

func main() {
	var i int = 42
	fmt.Printf("%v, %T\n", i, i)

	var j string = string(i)
	j = strconv.Itoa(i)
	fmt.Printf("%v, %T\n", j, j)
}

```

- Konvertieren von Strings: `strconv` Paket -> [Doku](https://pkg.go.dev/strconv)
- Konvertieren nach String: `string()`

---

# Konvertieren - Fazit

- Fazit:
  - In der Praxis viele Konventionen mit `zieltyp()` Funktion
  - Beim Arbeiten mit Strings `strconv` Paket verwenden
  - Go konvertiert nicht "ohne Rücksprache", z.B. um `int8` und `int16` zu addieren, muss konvertiert werden

---

# For Schleife 1

```go
package main

import "fmt"

func main() {
  sum := 0
  for i :=0; i<100; i++ {
    sum +=i
  }
  fmt.Println(sum)
}
```

- For Schleife wie in C++/Java/etc
- Keine Klammern notwendig
- Initialisierung (`i:=0`) und Post-Statement (`i++`) können weggelassen werden

---

# For Schleife 2

```go
package main

import "fmt"

func main() {
  sum := 0
  for i :=0; i<100; i++ {
    sum +=i
  }
  fmt.Println(sum)
}
```

- Ausprobieren: Gebe `i` aus - in der Schleife und ausserhalb
- was macht `continue`?
- was macht `break`?

---

# While Schleife

```go
package main

import "fmt"

func main(){
  sum :=1
  for sum < 100 {
    sum += sum
  }
  fmt.Println(sum)
}
```

- `for` verhält sich wie `while` mit nur der Abbruchbedingung
- Kein weiteres Schlüsselwort
- Komplett ohne Argumente (`for { ...}`) ist es eine unendliche Schleife (vgl. `while True:`)

---

# Arrays 1

```go
package main

import "fmt"

func main(){
  shoesizes := [3]{45, 46, 47}
  fmt.Printf("Sizes: %v\n", shoesizes)
  fmt.Printf("First Size: %v\n", shoesizes[0])
}
```

- Beinhaltet fixen Typ (vgl Python: Listen)
- Fixe Länge!
- Legen im Speicher am Stück -> Schnell
- Iterable -> Nutzbar mit Schleifen

---

# Arrays 2

```go
package main

import "fmt"

func main(){
  shoesizes := [...]{45, 46, 47}
  fmt.Printf("Sizes: %v\n", shoesizes)
  fmt.Printf("First Size: %v\n", shoesizes[0])
}
```

- Länge automatisch zur Compilezeit berechnet

---

# Arrays 3

```go
package main

import "fmt"

func main() {
	var shoesizes [3]int
	shoesizes[1] = 42
	fmt.Printf("Sizes: %v\n", shoesizes)
}
```

- Initialisiert mit angegebener Länge
- Inhalt mit *default value* initialisiert

---

# Arrays 4

```go
package main

import "fmt"

func main() {
	var matrix [3][3]int
  matrix[0] = [3]int{1,0,1}
  matrix[1] = [3]int{0,1,0}
  matrix[2] = [3]int{0,1,1}
  fmt.Println(matrix)
}
```

- Arrays können geschachtelt werden

---

# Arrays 5

```go
package main

import "fmt"

func main() {
	a := [...]int{47, 11, 42}
	b := a
	a[0] = 0
	fmt.Println(a)
	fmt.Println(b)
}

```

- In Go sind Arrays Werte-Typen!
- Achtung: Beim Übergeben an eine Funktion werden die Werte kopiert -> Zeiger (später)

---

# Slices 1

```go
package main

import "fmt"

func main() {
	a := []int{47, 11, 42}
	b := a
	a[0] = 0
	fmt.Println(a)
	fmt.Println(b)
}
```

- vgl. Listen in Python
- Slice: Referenz-Typ!

---

# Slices 2

```go
package main

import "fmt"

func main() {
	a := []int{47, 11, 42}
	fmt.Printf("Length: %v\n", len(a))
	fmt.Printf("Capacity: %v\n", cap(a))
}
```

- Liegt *nicht* zwangsläufig am Stück im Speicher -> *Langsamer* als Array
- Länge & Kapazität
- Länge/Kapazität erweiterbar zur Laufzeit -> Flexibel

---

# Slices 3

```go
package main

import "fmt"

func main() {
	a := []string{"Fry", "Leela", "Bender", "Zoidberg", "Amy"}

	b := a[:] // Alle Elemente
	c := a[3:]
	d := a[:3]
	e := a[2:4]
	fmt.Println(a)
	fmt.Println(b)
	fmt.Println(c)
	fmt.Println(d)
	fmt.Println(e)
}

```

- Auswahl/Ranges: Wie Python!
- Format: [*von_inklusiv*:*bis_exklusiv*]

---

# Slices 4 - Make

```go
package main

import "fmt"

func main() {
	a := make([]int, 4)
  fmt.Printf("Length: %v\n", len(a))
  fmt.Printf("Capacity: %v\n", cap(a))
}

```

- Parameter: `Typ, Länge, [Kapazität]`
- Beim Anlegen bereits Kapazitätsangabe möglich

---

# Slices 5

```go
package main

import "fmt"

func main() {
	a := []int{}
	fmt.Printf("Length: %v\n", len(a))
	fmt.Printf("Capacity: %v\n", cap(a))

	a = append(a, 42)
	fmt.Printf("Length: %v\n", len(a))
	fmt.Printf("Capacity: %v\n", cap(a))

	a = append(a, 47, 11, 815, 3)
	fmt.Printf("Length: %v\n", len(a))
	fmt.Printf("Capacity: %v\n", cap(a))
}
```

- Mit Append können 1 bis n Parameter angehängt werden
- Go kümmert sich um was Wachsen der Kapazität

---

# Zusammenfassung Slices & Arrays 1

- Arrays:
  - Sammlung identischen Typs
  - Fixe Größe
  - Explizite Größenangabe `[3]int{1, 2, 3}`
  - Implizite Größe `[...]int{1, 2, 3}`
  - Zugriff via 0-Basiertem Index `a[1]`
  - Kopieren der Variable = Kopieren des gesamten Inhalts

---

# Zusammenfassung Slices & Arrays 2

- Slices:
  - Sammlung identischen Typs
  - Variable Größe
  - Direktes Nutzen `[]int{1, 2, 3}`
  - Anlegen mit Länge `make([]int, 3)`
  - Optionale Angabe der Kapazität `make([]int, 3, 10)`
  - Anfügen von neuen Daten mit `append`
  - Kopieren der Variable = Referenz auf identische Daten

---

# Maps 1

```go
package main

import "fmt"

func main() {
	romanNumerals := map[string]int{
		"I": 1,
		"V": 5,
		"X": 10,
	}
	fmt.Println(romanNumerals)
	fmt.Println(romanNumerals["X"])
}
```

- Schlüssel/Werte-Paar
- Schlüsseltyp muss....
  - eindeutig sein
  - vergleichbar sein
- Wert kann beliebig sein
- Reihenfolge *nicht* garantiert/fix!
- Was, wenn ein Wert nicht in der Map ist?

---

# Maps 2

```go
package main

import "fmt"

func main() {
	romanNumerals := map[string]int{
		"I": 1,
		"V": 5,
		"X": 10,
	}

	value, ok := romanNumerals["M"]

	fmt.Println(ok)
	fmt.Println(value)
}
```

- Go unterstützt mehrere Rückgabewerte
- Go kennt keine Exceptions!
- `ok` oder `err` sehr üblicher Name für Fehler- bzw. Erfolgs-Rückgabewerte

---

# Struct 1

```go
package main

import "fmt"

type CrewMember struct {
	age     int
	species string
	job     string
}

func main() {
	fry := CrewMember{
		age:     25,
		species: "Human",
		job:     "Delievery Boy",
	}

	bender := CrewMember{
		age:     4,
		species: "Robot",
		job:     "Bender",
	}

	fmt.Println(fry)
	fmt.Println(bender)
}
```

- Fasst mehrere Datentypen zusammen
- Extrem häufig verwendet
- "As close as it gets" zu Klassen!

---

# Struct 2

```go
package main

import "fmt"

type CrewMember struct {
	age     int
	species string
	job     string
}

func main() {
	fry := CrewMember{25, "Human", "Delievery Boy"}
	bender := CrewMember{4, "Robot", "Bender"}

	fmt.Println(fry)
	fmt.Println(bender)
}
```

- Kurzschreibweise: Reihenfolge!
- Schlecht für Wartbarkeit: Erweitert man später das `struct`, müssen alle Verwender ihren Aufruf ändern

---

# Struct 3

```go
package main

import "fmt"

func main() {
	aCrewMember := struct{ name string }{name: "Amy"}

	fmt.Println(aCrewMember)
}

```

- Anonymes Struct - Definition nur an Stelle der Verwendung
- Kann nicht wiederverwendet werden
- In der Praxis selten verwendet

---

# Struct 4

```go
package main

import "fmt"

func main() {
	aCrewMember := struct{ name string }{name: "Amy"}
	anotherCrewMember := aCrewMember
	anotherCrewMember.name = "Hermes"

	fmt.Println(aCrewMember)
	fmt.Println(anotherCrewMember)
}
```

- `struct` sind Werttypen
- Die Zuweisung kopiert alle Werte

---

# Composition 1

```go
package main

import "fmt"

type Vehicle struct {
	MaxSpeedInKMH     int
	PassengerCapacity int
}

type Bicycle struct {
	Vehicle  // Vehicle in Bicycle!
	TirePressureInBar float32
}

func main() {
	b := Bicycle{}
	b.MaxSpeedInKMH = 80
	b.PassengerCapacity = 1
	b.TirePressureInBar = 8

	fmt.Println(b)
}
```

- Bicycle beinhaltet Vehicle
- Daher ist der Typ gekapselt darin vorhanden
- Keine Vererbung, sondern Composition

---

# Composition 2

```go
package main

import "fmt"

type Vehicle struct {
	MaxSpeedInKMH     int
	PassengerCapacity int
}

type Bicycle struct {
	Vehicle           // Vehicle in Bicycle!
	TirePressureInBar float32
}

func main() {
	b := Bicycle{
		Vehicle: Vehicle{MaxSpeedInKMH: 80, PassengerCapacity: 1},
		TirePressureInBar: 8,
	}

	fmt.Println(b)
}

```

- Embedding: Gar nicht *so* oft verwendet, lieber mit Interfaces arbeiten (später!)
- Allgemein zu structs: Könnten mit Zusätzliche Information angereichert werden, mit denen z.B. JSON erzeugt werden kann

---

# If 1

```go
package main

import "fmt"

func main() {
	if true {
		fmt.Println("This is true")
	}
	if false {
		fmt.Println("This is false")
	}
}
```

- `if` benötigt keine Klammern!
- Sonst: Wie in allen Sprachen auch

---

# If 2

```go
package main

import "fmt"

func main() {
	romanNumerals := map[string]int{
		"I": 1,
		"V": 5,
		"X": 10,
	}

	if value, ok := romanNumerals["X"]; ok {
    fmt.Println(value)
  }
}
```

- Wie `for`, kann `if` eine Initialisierung haben
- Achtung: Scope von `ok` und `value`!

---

# If 3

```go
package main

import "fmt"

func main() {
	rateNummer := 47
	rateVersuch := 11

	if rateVersuch < rateNummer {
		fmt.Println("Zu klein")
	}
	if rateVersuch > rateNummer {
		fmt.Println("Zu gross")
	}
	if rateVersuch == rateNummer {
		fmt.Println("Erraten!")
	}
}
```

- Wie aus anderen Sprachen bekannte Vergleichsoperatoren: `>`, `<`, `==`, liefern einen `bool` Wert
- Logische Operatoren: `&&` (and), `||` (or), `!` (not)
- Achtung: Gleichheit von Gleitkommazahlen ist kompliziert

---

# If 4

```go
package main

import "fmt"

func main() {
	rateNummer := 47
	rateVersuch := 11

	if rateVersuch < rateNummer {
		fmt.Println("Zu klein")
	} else {
		if rateVersuch > rateNummer {
			fmt.Println("Zu gross")
		} else {
			fmt.Println("Erraten!")
		}
	}
}
```

- `else` Bereich wird ausgeführt, wenn `if` nicht `true` ist

---

# Switch 1

```go
package main

import "fmt"

func main() {
	switch 3 {
	case 1:
		fmt.Println("Eins")
	case 2:
		fmt.Println("Zwei")
	case 3:
		fmt.Println("Drei")
	default:
		fmt.Println("Unbekannt")
	}
}
```

- `switch` vergleicht mehrere Fälle nacheinander
- Trifft keiner zu, wird `default` aufgerufen

---

# Switch 2

```go
package main

import "fmt"

func main() {
	switch 3 {
	case 1, 3, 5, 7, 9:
		fmt.Println("Ungerade")
	case 2, 4, 6, 8:
		fmt.Println("Gerade")
	default:
		fmt.Println("Unbekannt")
	}
}
```

- `switch` kann auch mehrere Werte "durchsuchen"
- Werte dürfen sich nicht wiederholen

---

# Switch 3

```go
package main

import "fmt"

func main() {
	switch x := 3 + 2; x {
	case 1, 3, 5, 7, 9:
		fmt.Println("Ungerade")
	case 2, 4, 6, 8:
		fmt.Println("Gerade")
	default:
		fmt.Println("Unbekannt")
	}
}

```

- `switch` kennt wie `for` und `if` Initialisierungs-Schreibweise
- Achtung: Scope!

---

# Switch 4

```go
package main

import "fmt"

func main() {
  x := 4
	switch {
	case x <= 5:
		fmt.Println("Kleiner-gleich fünf")
	case x <= 10:
		fmt.Println("Kleiner-gleich zehn")
	default:
		fmt.Println("Größer als 10")
	}
}

```

- Achtung: Jetzt können sich die Werte/Bedingungen überschneiden
- Was, wenn ich möchte, dass bei `x=4` die ersten beiden Fälle ausgelöst werden sollen?

---

# Switch 5

```go
package main

import "fmt"

func main() {
  x := 4
	switch {
	case x <= 5:
		fmt.Println("Kleiner-gleich fünf, und damit auch...")
    fallthrough
	case x <= 10:
		fmt.Println("Kleiner-gleich zehn")
	default:
		fmt.Println("Größer als 10")
	}
}
```

- `break` gibt es nicht, da dies in vielen Sprachen vergessen wird!
- Go dreht dies um
- `fallthrough` lässt auch die nächste(n) cases prüfen und ggf.ausführen

---

# Switch 6

```go
package main

import "fmt"

func main() {
	var i interface{} = 1
	switch i.(type) {
	case int:
		fmt.Println("i ist integer")
	case float64:
		fmt.Println("i ist float64")
	case string:
		fmt.Println("i ist string")
	default:
		fmt.Println("i ist etwas anderes")
	}
}
```

- Mit `case` kann auch nach Eingangstyp unterschieden werden

---

# For Schleife 3

```go
package main

import "fmt"

func main() {
	romanNumerals := map[string]int{
		"I": 1,
		"V": 5,
		"X": 10,
	}
	for key, value := range romanNumerals {
		fmt.Println(key, value)
	}
}
```

- Schlüssel und Wert abklappern
- Was passiert bei anderen Typen (z.B. `[]int`, `string`)?

---

# Defer 1

```go
package main

import "fmt"

func main() {
	fmt.Println("Eins")
	defer fmt.Println("Zwei")
	fmt.Println("Drei")
}
```

- Führt *später* aus (beim Verlassen der Funktion)
- Praktisch für *Aufräumarbeiten*

---

# Defer 2-1

```go
package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

func main() {
	result, err := http.Get("https://heise.de")
	if err != nil {
		log.Fatal(err)
	}

	defer result.Body.Close()

	data, err := ioutil.ReadAll(result.Body)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("%s", data)
}
```

---

# Defer 2-2

- `result.Body.Close()` sollte nach dessen Verwendung ausgeführt werden
- Wie kann man sichgehen, dass es nicht vergessen wird, aber auch nicht zu früh ausgeführt? -> `defer`
- Erlaubt z.B. Laden von Daten und abschliessendes "schliessen" im Programm zusammen zu halten, ohne dies gleich auszuführen
- Extrem häufiges Pattern
- Achtung: `defer` in Schleifen: Freigabe erst beim Verlassen der Funktion -> Bei grossen Schleifen SEHR viele Resourcen!

---

# Defer 3

```go
package main

import "fmt"

func main() {
	a := "Eins"
	defer fmt.Println(a)
	a = "Zwei"
}
```

- Was wird ausgegeben?

---

# Panic 1

```go
package main

import "fmt"

func main() {
	x, y := 1, 0
	div := x / y
	fmt.Println(div)
}
```

- Was passiert wohl?

---

# Panic 2

```go
package main

import "fmt"

func main() {
	fmt.Println("Anfang")
	panic("Etwas schlimmes ist passiert")
	fmt.Println("Ende")
}
```

- Was passiert?

---

# Panic 4

```go
package main

import (
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte("Hello, World!"))
	})
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		panic(err.Error())
	}
}

```

- Was passiert?
- Was passiert, wenn ich das Programm zwei Mal starte?

---

# Panic 5

```go
package main

import "fmt"

func main() {
	fmt.Println("Eins")
	defer fmt.Println("Deferred")
	panic("panic")
	fmt.Println("Zwei")
}

```

- Was wird ausgegeben? In welcher Reihenfolge?
- Wichtig: Erst `defer`, dann `panic`
- Also: Resourcen mit `defer` Schliessen ist auch bei `panic` sicher!

---

# Panic 6

- `panic` wird eingesetzt um ein Programm zu beenden
- Wenn wirklich *nichts mehr geht*, z.B. geblockter Port für Webserver
- Go erzeugt selbst `panic` bei Fehlern
- Erweitert: Mit `recover` können innerhalb von mit `defer` versehene Funktionen ein `panic` aufgehalten werden
- Design: `panic` nie als "alternativen" Programmflow nutzen!

---

# Pointer 1

```go
package main

import "fmt"

func main() {
	a := 42
	b := a
	fmt.Println(a, b)
	b = 11
	fmt.Println(a, b)
}
```

- `a` und `b` sind Werte
- `b := a` kopiert den Wert

---

# Pointer 2

```go
package main

import "fmt"

func main() {
	a := 42
	b := &a
	fmt.Println(a, b)
	fmt.Println(a, *b)
	fmt.Println(&a, b)

	a = 11
	fmt.Println(a, b)
	fmt.Println(a, *b)
	fmt.Println(&a, b)

	*b = 47
	fmt.Println(a, b)
	fmt.Println(a, *b)
	fmt.Println(&a, b)
}
```

- `&` macht aus dem Wert einen Zeiger darauf
- `*` macht aus einem Zeiger den Wert dahinter "dereferenzieren"
- `b` ist ein *Zeiger* auf einen *int* Typ: `*int`
- `b := &a` legt einen *Zeiger* auf `a` an

---

# Pointer 3

```go
package main

import "fmt"

func main() {
	a := [4]int{1,2,3,4}
	b := &a[0]
	c := &a[1]
	fmt.Printf("%v %p %p\n", a, b, c)
}
```

- Erinnerung: Arrays liegen am Stueck
- Speicheradressen liegen hinterinander im Speicher
- Aber: Go erlaubt *keine* Zeigeraritmetik!
- Wer das braucht: Paket `unsafe` der Standardbibliothek

---

# Different Pointers 1

```go
package main

import "fmt"

type crewMember struct {
	age int
}

func main() {
	var cm *crewMember
	fmt.Println(cm)
	cm = new(crewMember)
	fmt.Println(cm)
}
```

- Welchen Wert hat ein Pointer (noch) ohne Wert dahinter?
- Praxis: Funktion, die Zeiger entgegen nimmt muss checken, ob ein Wert `nil` ist

---

# Different Pointers 2

```go
package main

import "fmt"

type crewMember struct {
	age int
}

func main() {
	var cm *crewMember
	cm = new(crewMember)
	(*ms).foo = 42
	// ms.foo = 42
	fmt.Println(cm)
}
```

- Statt explizit zu dereferenzieren, koennen wir die Kurzzschreibweise `ms.foo` nutzen

---

# Different Pointers 3

```go
package main

import "fmt"

func main() {
	a := [...]int{1,2,3,4}
	b := a
	fmt.Println(a,b)
	a[1]=47
	fmt.Println(a,b)
}
```

- Aendert sich b auch? Warum/Warum nicht?

---

# Different Pointers 4

```go
package main

import "fmt"

func main() {
	a := []int{1,2,3,4}
	b := a
	fmt.Println(a,b)
	a[1]=47
	fmt.Println(a,b)
}
```

- Aendert sich b auch? Warum/Warum nicht?
- An Typ denken! (Array vs. Slice)
- Auch bei Maps: Sind Referenztypen nicht Werttypen

---

# Funktionen (erweitert) 1

```go
package main

import "fmt"

func sayHello (gruss, name string) {
	fmt.Printf("%v %v\n", gruss, name)
	gruss = "ciao!"
}

func main() {
	myName := "Philipp"
	myGreeting := "Hallo"
	sayHello(myGreeting,myName)
	fmt.Println(myGreeting)
}
```

- Was passiert?
- Warum?

---

# Funktionen (erweitert) 2

```go
package main

import "fmt"

func sayHello (gruss, name *string) {
	fmt.Printf("%v %v\n", *gruss, *name)
	*gruss = "ciao!"
}

func main() {
	myName := "Philipp"
	myGreeting := "Hallo"
	sayHello(&myGreeting, &myName)
	fmt.Println(myGreeting)
}
```

- Zeiger werden eingereicht, nicht Wertkopien!
- Manipulieren moeglich
- Sehr schneller Zugriff (weil keine Kopie)a

---

# Funktionen (erweitert) 3

```go
package main

import "fmt"

func sum (values ...int ) *int {
	fmt.Println(values)
	result :=0
	for _, v := range values {
		result += v
	}
	return & result
}

func main() {
	s := sum(1,2,3,4,5,6)
	fmt.Println("Die Summe ist ", *s)
}
```

- Es wird ein *LOKALER Zeiger*  zurueckgegeben!
- Dies wird aber von Go erledigt -> Erlaubt!
- `_` ist Platzhalter fuer unbenutzte Variable
- `...` nimmt beliebig viele Daten eines Typs entgegen. Muss als letztes Elemente in der Parameterliste auftauchen

---

# Funktionen (erweitert) 4

```go
package main

import "fmt"

func sum (values ...int ) *int {
	fmt.Println(values)
	result :=0
	for _, v := range values {
		result += v
	}
	return & result
}

func main() {
	s := sum(1,2,3,4,5,6)
	fmt.Println("Die Summe ist ", *s)
}
```

- Es wird ein *LOKALER Zeiger*  zurueckgegeben!
- Dies wird aber von Go erledigt -> Erlaubt!
- `_` ist Platzhalter fuer unbenutzte Variable
- `...` nimmt beliebig viele Daten eines Typs entgegen. Muss als letztes Elemente in der Parameterliste auftauchen

---

# Funktionen (erweitert) 5

```go
package main

import "fmt"

func divide(x, y float64) (float64, error) {
	if y == 0.0 {
		return 0.0, fmt.Errorf("Cannot divide by zero")
	}
	return x / y, nil
}

func main() {
	d, err := divide(5.0, 0.0)
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Println(d)
}
```

- Sehr üblich: als letzten Parameter `error` Typ zurueckgeben
- Dann als Aufrufer: Wert auf `!=nil` pruefen
- Erinnerung: Keine Exceptions!

---

# Funktionen (erweitert) 6

- Erweitertes:
- Funktionen koennen auch als Paramter genutzt werden - und haben auch Typen/Signaturen
- Dies spielt zumeist mit anonymen Funktionen zusammen

```go
a := func (){ // Funktion
}
```

- Erinnerung: *Named return values* - Achtung beim Einsatz: Kann verwirrender sein, als Klarheit zu schaffen

---

# Interfaces 1

- Ein Killerfeature von Go!
- Verbindet Typen und Funktionen
- *Alternative* zu Methoden (gibt ja keine Objekte!)
- Schafft langfristig wartbare, aber erweiterbare Programme
- Beschreibt, dass *etwas etwas kann*

---

# Interfaces 2

```go
package main

import "fmt"

// Interface name: verb+er
type Writer interface {
	Write([]byte) (int,error)
}
type ConsoleWriter struct {}

func (cw ConsoleWriter) Write(data []byte) (int,error){
	n, err := fmt.Println(string(data))
	return n,err
}

func main() {
	var w Writer = ConsoleWriter{}
	w.Write([]byte("Hello Go"))
}
```

---

# Interfaces 3

```go
package main

import "fmt"

type IntCounter int

type Incrementer interface {
	Increment() int
}

func (ic *IntCounter) Increment() int {
	*ic++
	return int(*ic)
}

func main() {
	myInt := IntCounter(0)
	var inc Incrementer = &myInt
	for i:=0; i<10; i++ {
		fmt.Println(inc.Increment())
	}
}
```

- Eigener Typ `IntCounter` statt `int`, da wir `int` nicht *besitzen*
- -> Interfaces kommen aus der gleichen Quelle
- -> Um vorhandene (Fremd-)typen Interfaces zu geben, muss ich eigene Typen daraus machen

---

# Interfaces 4

- Erweitert: Interfaces k"onnen aus anderen Interfaces zusammengesetzt werden

```go
type WriterCloser interface {
	Writer
	Closer
}
```

- `Writer` z.B. ein extrem haeufig genutzes Interface
- Erinnerung: Alle Elemente, fuer die Funktionen existieren, die ein Interface fordert, erfuellen dieses Interface und koennen dann genutzt werden

---

# Interfaces 5

- Allgemein: Lieber kleine Interfaces als grosse Monolithische
- Beispiele fuer Interfaces: `io.Writer`, `io.Reader`, `empty`
- Interfaces nicht exportieren, falls sie von aussen nicht gebraucht werden
- Interfaces exportieren fuer alles, was von aussen zugaenglich sein muss!
- Interfaces werden implizit stat explizit definiert (vgl. C#, Java)

---

# Go Routinen 1

```go
package main

import (
	"fmt"
	"time"
)

func printAndSleep(){
	fmt.Println("start")
	time.Sleep(2 * time.Second)
	fmt.Println("done")
	time.Sleep(2 * time.Second)
}

func main(){
	for i:=0;i<3;i++{
		printAndSleep()
	}
	time.Sleep(10 * time.Second)
	fmt.Println("Done!")
}
```

- Fuer viele DER Grund Go zu lernen
- Threads, um alles kuemmert sich Go mit einem Scheduler
- Was ist die Ausgabe, wie wird gewartet?

---

# Go Routinen 2

```go
package main

import (
	"fmt"
	"time"
)

func printAndSleep(){
	fmt.Println("start")
	time.Sleep(2 * time.Second)
	fmt.Println("done")
	time.Sleep(2 * time.Second)
}

func main(){
	for i:=0;i<3;i++{
		go printAndSleep()
	}
	time.Sleep(10 * time.Second)
	fmt.Println("Done!")
}
```

- Was ist die Ausgabe, wie wird gewartet?
- Was passiert, wenn wir das `time.Sleep(10 * time.Second)` weglassen?

---

# Go Routinen 3

```go
package main

import (
	"fmt"
	"time"
	"sync"
)

func printAndSleep(){
	fmt.Println("start")
	time.Sleep(2 * time.Second)
	fmt.Println("done")
	time.Sleep(2 * time.Second)
}

func main(){
	var wg sync.WaitGroup

	for i:=0;i<3;i++{
		wg.Add(1)
		go func () {
			defer wg.Done()
			printAndSleep()
		}()
	}
	wg.Wait()
	fmt.Println("Done!")
}
```

- Mit einer Waitgroup loesen wir das warten auf alle Routinen sauber
- Löst *race conditions*

---

# Go Routinen 4

## Tipps

- Schreibe Routinen/Bibliotheken single-threaded - der Benutzer kann dich parallel ausführen! (Ausnahme: Nutzen von channels)
- Schütze deinen Abläufe/Race Conditions mit Waitgroups und/oder einer Mutex (z.B. `RWMutex`)
- Das Thema saubere / optimierte Parallelisierung ist kniffelig!
- Programm mit Parallelität mit `go run -race main.go` starten um race conditions zu finden
- That's it!

---

# Channels 1

- Channels: *Röhren* zwischen Go Routinen
- Die Lösung zum Senden/Empfangen zwischen Routinen
- Typisiert

---

# Channels 2

```go
package main

import (
	"fmt"
	"sync"
)

var wg = sync.WaitGroup{}

func main() {
	ch := make(chan int)
	wg.Add(2)
	go func() {
		i := <-ch
		fmt.Println(i)
		wg.Done()
	}()

	go func() {
		ch <- 47
		wg.Done()
	}()
	wg.Wait()
}
```

- Die erste Routine *liest* aus dem Kanal und gibt es a
- Die zweite Routine *schreibt* in den Kanal
- Beide *dürfen* aber lesen UND schreiben

---

# Channels 3

```go
package main

import (
	"fmt"
	"sync"
)

var wg = sync.WaitGroup{}

func main() {
	ch := make(chan int)
	for j := 0; j < 10; j++ {
		wg.Add(2)
		go func() {
			i := <-ch
			fmt.Println(i)
			wg.Done()
		}()

		go func() {
			ch <- 47
			wg.Done()
		}()
	}
	wg.Wait()
}
```

- "Das skaliert!"

---

```go
package main

import (
	"fmt"
	"sync"
)

var wg = sync.WaitGroup{}

func main() {
	ch := make(chan int)
	wg.Add(2)
	go func(ch <-chan int) {
		i := <-ch
		fmt.Println(i)
		wg.Done()
	}(ch)

	go func(ch chan<- int) {
		ch <- 47
		wg.Done()
	}(ch)
	wg.Wait()
}
```

- Read-only channel
- Write-only channel
- Macht Datenfluss *viel* deutlicher!

---

# Channels 4

```go
package main

import (
	"fmt"
	"sync"
)

var wg = sync.WaitGroup{}

func main() {
	ch := make(chan int)
	wg.Add(2)
	go func(ch <-chan int) {
		i := <-ch
		fmt.Println(i)
		wg.Done()
	}(ch)

	go func(ch chan<- int) {
		ch <- 47
		ch <- 11
		wg.Done()
	}(ch)
	wg.Wait()
}
```

- Was passiert? Was ist das Problem?

---
# Channel 5

```go
package main

import (
	"fmt"
	"sync"
)

var wg = sync.WaitGroup{}

func main() {
	ch := make(chan int, 20)
	wg.Add(2)
	go func(ch <-chan int) {
		i := <-ch
		fmt.Println(i)
		wg.Done()
	}(ch)

	go func(ch chan<- int) {
		ch <- 47
		ch <- 11
		wg.Done()
	}(ch)
	wg.Wait()
}
```

- Buffer in Kanal mit Kapazität
- Fängt spitzen etc. ab

---

# Channel 6

```go
package main

import (
	"fmt"
	"sync"
)

var wg = sync.WaitGroup{}

func main() {
	ch := make(chan int, 20)
	wg.Add(2)
	go func(ch <-chan int) {
		for i := range ch {
			fmt.Println(i)
		}
		wg.Done()
	}(ch)

	go func(ch chan<- int) {
		ch <- 47
		ch <- 11
		close(ch)
		wg.Done()
	}(ch)
	wg.Wait()
}
```

- Mit Schleife auf Kanal
- Achtung: Am Ende muss der Channel geschlossen werden!
- Aber: In geschlossene Channels kann nicht (mehr) geschrieben werden

---

# Channels 7
```go
package main

import (
	"fmt"
	"time"
)

const (
	logInfo    = "INFO"
	logWarning = "WARNING"
	logError   = "ERROR"
)

type logEntry struct {
	time     time.Time
	severity string
	message  string
}

var logCh = make(chan logEntry, 20)

func main() {
	go logger()
	logCh <- logEntry{time.Now(), logInfo, "Dienst startet"}
	time.Sleep(2 * time.Second)
	logCh <- logEntry{time.Now(), logInfo, "Dienst wird beendet"}

	time.Sleep(5 * time.Second)
}

func logger() {
	for entry := range logCh {
		fmt.Printf("%v - [%v] %v\n", entry.time.Format("2021-11-20T15:45:44"), entry.severity, entry.message)
	}
}
```
---
# Channels 8

- Das Programm ist gültig beendet, wenn die `main` routine beendet ist
- Wie kann ich aber "bescheid sagen", dass etwas zu Ende geht?

---

# Channels 9

```go
package main

import (
	"fmt"
	"time"
)

const (
	logInfo    = "INFO"
	logWarning = "WARNING"
	logError   = "ERROR"
)

type logEntry struct {
	time     time.Time
	severity string
	message  string
}

var logCh = make(chan logEntry, 20)
var doneCh = make(chan struct{})

func main() {
	go logger()
	logCh <- logEntry{time.Now(), logInfo, "Dienst startet"}
	time.Sleep(2 * time.Second)
	logCh <- logEntry{time.Now(), logInfo, "Dienst wird beendet"}

	time.Sleep(5 * time.Second)
	doneCh <- struct{}{}
}

func logger() {
	for {
		select {
		case entry := <-logCh:
			fmt.Printf("%v - [%v] %v\n", entry.time.Format("2021-11-20T15:45:44"), entry.severity, entry.message)
		case <-doneCh:
			break
		}
	}
}
```

---

# Channels 10

- Neben *done*-Channels gibt es noch viele andere Anwendungen für mehrer Kanäle:
  - Zustandsänderunge
  - Timeouts (z.B. mit einem Kanal, der regelmäßig Signale schickt)
  - u.v.m.
- Kanäle sind *extrem* mächtig und in Zusammenspiel mit Go Routinen ermöglichen sie *extrem* einfach, *extrem starke* Parallelisierung

---

# Anhang

- Wiederauffrischen: [Go Tour](https://tour.golang.org/)

---

<div align="center">
  <img src="https://raw.githubusercontent.com/linuxhubit/catfacts/master/data/icons/64/com.github.linuxhubit.catfacts.svg" width="64">
  <h1 align="center">Cat Facts</h1>
  <p align="center">Find cat facts</p>
</div>

<br/>

<div align="center">
   <a href="https://github.com/linuxhubit/catfacts/blob/master/LICENSE">
    <img src="https://img.shields.io/badge/License-GPL--3.0-blue.svg">
   </a>
</div>

<div align="center">
    <img  src="https://github.com/linuxhubit/catfacts/raw/master/data/screenshot-1.png">
</div>

## Problems/New Features?
Open a new Issue [here](https://github.com/linuxhubit/catfacts/issues).

## How to run
```bash
com.github.linuxhubit.catfacts
```

## Installation

### From PPA
Configure PPA:
```bash
curl -s --compressed "https://linuxhubit.github.io/ppa/KEY.gpg" | sudo apt-key add -
sudo curl -s --compressed -o /etc/apt/sources.list.d/my_list_file.list "https://linuxhubit.github.io/ppa/my_list_file.list"
sudo apt update
```
then install:
```bash
sudo apt install com.github.linuxhubit.catfacts
```

### From .deb package
Grab an updated release [here](https://github.com/linuxhubit/catfacts/releases), then install:

```bash
sudo dpkg -i com.github.linuxhubit/catfacts*.deb
```




# ☁️ Azure Linux VM mit Terraform

![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%237B42BC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

Dieses Projekt automatisiert die Bereitstellung einer **Ubuntu Linux Virtual Machine** in Microsoft Azure mithilfe von **Terraform**.

Es demonstriert Infrastructure as Code (IaC) Best Practices: Modularisierung, Variablen-Nutzung und den Umgang mit Cloud-Ressourcenbeschränkungen.

## 🏗️ Architektur

Der Code provisioniert eine vollständige Umgebung in einer neuen Resource Group:

* **Networking:** Virtual Network (VNet), Subnet, Public IP und Network Interface (NIC).
* **Security:** Network Security Group (NSG) (Firewall), die nur **SSH (Port 22)** erlaubt.
* **Compute:** Eine Ubuntu 22.04 LTS Virtual Machine.

### 💡 Besonderheit: ARM64 Architektur
Aufgrund von Kapazitätsengpässen in der Region `germanywestcentral` (Frankfurt) nutzt dieses Projekt eine angepasste **ARM-Architektur**, um Kosten zu optimieren und Verfügbarkeit zu garantieren:
* **VM Size:** `Standard_B2ps_v2` (Ampere Altra ARM Prozessor)
* **Image:** Ubuntu 22.04 LTS (**arm64** Version)

## 🚀 Voraussetzungen

* **Terraform CLI** (installiert)
* **Azure CLI** (`az login` erfolgreich ausgeführt)
* Ein lokales **SSH-Schlüsselpaar** (`~/.ssh/id_rsa.pub`)

## 🛠️ Installation & Start

1.  **Repository klonen**
    ```bash
    git clone [https://github.com/ArditCloudDev/terraform-azure-vm.git](https://github.com/ArditCloudDev/terraform-azure-vm.git)
    cd terraform-azure-vm
    ```

2.  **Initialisieren**
    Lädt den Azure-Provider herunter.
    ```bash
    terraform init
    ```

3.  **Planen & Überprüfen**
    Zeigt, welche Ressourcen erstellt werden.
    ```bash
    terraform plan
    ```

4.  **Deployment (Apply)**
    Erstellt die Infrastruktur in Azure.
    ```bash
    terraform apply
    ```
    *(Bestätige die Abfrage mit `yes`)*

## 🔌 Verbindung zur VM

Terraform gibt nach dem Deployment automatisch den fertigen SSH-Befehl aus.
Du musst ihn nur kopieren und einfügen:

```bash
# Beispiel Output:
ssh_connection_string = "ssh adminuser@135.220.xx.xx"
```

## ⚙️ Konfiguration (Variables)

Die Einstellungen können in der Datei `variables.tf` angepasst werden:

| Variable | Beschreibung | Standardwert |
| :--- | :--- | :--- |
| `location` | Azure Region | `germanywestcentral` |
| `vm_size` | Größe der VM | `Standard_B2ps_v2` (ARM64) |
| `admin_username` | Benutzername | `adminuser` |

## 🧹 Aufräumen

Um Kosten zu vermeiden, wenn die VM nicht mehr benötigt wird:

```bash
terraform destroy
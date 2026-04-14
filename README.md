# 🛡️ Case: Governança de Identidade e Controle de Acesso (IAM/GRC)
## Fintech Global - Projeto ZTIG (Zero Trust Identity Governance)

Este projeto apresenta a solução de infraestrutura e governança de acesso desenvolvida para a **Fintech Global**. O desafio consistia em garantir que os logs de auditoria (dados críticos de conformidade) fossem acessíveis apenas por pessoal autorizado, sob condições rigorosas de contexto.

---

## 📖 A História do Projeto (The Business Case)

A auditora sênior da Fintech fictícia , precisava acessar logs financeiros armazenados na AWS. No entanto, em um cenário de Fintech, o acesso não pode ser concedido de forma simples. O risco de vazamento de dados ou acesso por credenciais comprometidas exigia uma solução de **IAM** robusta.

**O Desafio:**
1. **Risco:** Acesso indevido a logs sensíveis por atores internos ou externos.
2. **Conformidade:** Necessidade de atender requisitos de **LGPD** e **PCI-DSS** sobre rastreabilidade.
3. **Governança:** Eliminar o uso de permissões diretas em usuários (Inline Policies).

---

## 🏗️ Estrutura da Solução (Modular Design)

O projeto foi arquitetado em **Terraform** seguindo o padrão de módulos para garantir o isolamento de privilégios e a organização da governança:

* **`modules/iam`**: O cérebro da governança. Contém a definição de Roles, Policies e a lógica de confiança (Trust Relationships).
* **`modules/s3`**: O repositório de dados. Implementa o *Hardening* do bucket com políticas baseadas em recurso.



---

## ⚖️ Pilares de GRC (Governança, Risco e Compliance)

Como Analista de IAM, este projeto foca nos seguintes controles de segurança:

### 1. Segregação de Funções (SoD) & RBAC
Implementei o modelo **Role-Based Access Control**. Em vez de permissões permanentes, criamos a `FTG-Auditor-Role`. O acesso é temporário e baseado na função (Job Function), reduzindo a superfície de ataque.

### 2. Defesa em Profundidade (Context-Aware Access)
A política de acesso não verifica apenas "quem", mas "como" e "de onde":
* **Controle de Origem (IP Whitelisting)**: Bloqueio imediato (`Explicit Deny`) para qualquer requisição fora do IP corporativo autorizado.
* **Autenticação Forte (MFA)**: Condição lógica que exige Multi-Factor Authentication para leitura de objetos, mitigando o risco de roubo de credenciais.

### 3. Prevenção de Drift e Auditoria
O uso de **Terraform** garante que a governança seja imutável. Qualquer alteração manual no console da AWS será detectada como um desvio (Drift) de conformidade.

---

### IAM Policy Logic (Trecho de Código)

```hcl
# Exemplo da lógica de bloqueio preventivo (GRC)
# Garante que o acesso só ocorra via IP autorizado e com MFA ativo
Condition = {
  NotIpAddress = {
    "aws:SourceIp" = [var.my_ip] 
  },
  Bool = {
    "aws:MultiFactorAuthPresent" = "true"
  }
}
```
---

### 🚀 Como Validar a Governança

**1. Clone o repositório:**
```bash
git clone https://github.com/igor-it-portfolio/projeto-ztig-fintech.git

terraform init
Valide a conformidade técnica (Sintaxe e Variáveis):

terraform validate
Gere o relatório de impacto (Simulação de Auditoria):

terraform plan
```
---
   👨‍💻 Perfil do Desenvolvedor
Igor Pantoja. - Especialista em Governança de Identidade (IAM) e Cloud Security.

Focado em transformar requisitos complexos de conformidade em código seguro e auditável.

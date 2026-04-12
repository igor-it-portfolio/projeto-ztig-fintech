# Relatório de Governança e Segurança IAM - Projeto ZTIG 🛡️

## 1. Visão Geral
Este repositório contém a implementação do framework **ZTIG (Zero Trust IAM Governance)** para a infraestrutura de auditoria de uma FinTech fícticia. O objetivo é garantir que o acesso aos logs críticos seja restrito, monitorizado e à prova de falhas geográficas.

## 2. Pilares de Segurança Implementados

### A. Perímetro de Rede Dinâmico (The Manaus Perimeter)
**Problema:** Credenciais de acesso podem ser roubadas. Se um atacante obtiver as chaves do Auditor, poderia aceder aos logs de qualquer parte do mundo.
**Solução:** Implementei uma restrição de `aws:SourceIp` em todas as políticas. 
- **Estado Atual:** O acesso está restrito exclusivamente ao IP de trabalho (`45.184.202.114`).
- **Resultado:** Mesmo com a password correta, o acesso é negado se não vier da rede autorizada.

### B. Privilégio Mínimo (ComplianceAuditorRole)
**Problema:** Utilizadores com permissões excessivas (Admin) aumentam o risco de desastres acidentais.
**Solução:** Criei uma Role específica que:
- Não tem permissão para criar recursos.
- Possui apenas permissão de **Leitura (ReadOnly)** no Bucket de Auditoria.
- Utiliza ARNs variáveis para garantir que a Role só "vê" o que foi designado no `variables.tf`.

### C. Proteção contra Eliminação (MFA Enforcement)
**Problema:** Eliminação acidental ou maliciosa de logs de auditoria.
**Solução:** Adicionei uma cláusula de `Deny` explícito para as ações `s3:DeleteObject` e `s3:DeleteBucket`.
- **Regra:** A operação só é permitida se o utilizador estiver autenticado com um dispositivo MFA ativo (`aws:MultiFactorAuthPresent`).

## 3. Gestão de Risco e Monitorização
Utilizei o **AWS Access Analyzer** (configurado no `audit.tf`) para verificar continuamente se existem políticas que permitem acesso externo não autorizado. Este componente gera alertas automáticos sobre "Achados de Segurança" (Findings).

## 4. Como Operar este Repositório
- **Atualização de IP:** Caso a rede da empresa mude, o IP deve ser atualizado no ficheiro `variables.tf` para propagar a segurança em toda a infraestrutura.
- **Assumir a Role:** O utilizador deve utilizar o serviço STS para assumir a `ComplianceAuditorRole`, garantindo que as sessões sejam efêmeras (temporárias).

---
**Responsável Técnico:** Igor C.
**Framework:** Terraform / AWS IAM Zero Trust
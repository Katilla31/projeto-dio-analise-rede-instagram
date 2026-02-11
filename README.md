# Projeto de Análise de Redes Sociais com Neo4j

Neste projeto foram analisados dados do Instagram utilizando o banco de dados orientado a grafos **Neo4j**. O objetivo é extrair insights sobre engajamento, popularidade de conteúdo e comunidades de interesse, procurando responder o seguinte problema proposto no desafio de projeto da DIO "
Analisando Dados de Redes Sociais com Base em Consultas de Grafos":


Uma startup de análise de mídias sociais deseja criar um novo produto que ofereça insights
sobre o engajamento e as conexões entre usuários em uma plataforma. Eles precisam
de um protótipo funcional que possa responder a perguntas sobre interações de 
usuários, popularidade de conteteúdo e comunidade de interesse.

## 🚀 Tecnologias Utilizadas
* **Neo4j AuraDB**: Banco de dados em nuvem.
* **Cypher**: Linguagem de consulta para grafos.
* **GitHub**: Hospedagem dos dados e scripts.

## 📊 Estrutura do Grafo
O modelo de dados consiste em:
* **Account (Nó)**: Perfis de criadores ou marcas.
* **Post (Nó)**: Publicações individuais.
* **Category (Nó)**: Nichos de interesse (Music, Fitness, etc.).
* **Relacionamentos**: `(Account)-[:POSTED]->(Post)-[:BELONGS_TO]->(Category)`.

## 🔍 Problemas Resolvidos
O script incluído realiza:
1. **Auditoria de Dados**: Verificação de duplicatas e valores nulos antes da importação.
2. **Importação Automatizada**: Uso do `LOAD CSV` para carregar 30 mil registros.
3. **Análise de Popularidade**: Identificação do tipo de mídia com maior alcance (Imagens vs Reels).
4. **Análise de Comunidades**: Ranking de nichos por taxa de engajamento (liderado por Music).
5. **Ranking de Influência**: Identificação das contas com maior volume de interações.

## 🛠️ Como Executar
1. Crie uma instância no **Neo4j Aura**.
2. Execute as constraints de unicidade presentes no arquivo `.cypher`.
3. Rode o script de `LOAD CSV` (certifique-se de atualizar a URL para o link RAW do seu arquivo CSV).
4. Execute as queries de insight para visualizar os resultados.

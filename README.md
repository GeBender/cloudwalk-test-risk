# Software Engineer - Risk test to CloudWalk

Projeto versionado com o objetivo de servir como base de avaliação para a **CloudWalk** no processo de seleção para a vaga de **Engenheiro de Software** Ruby on Rails.

  

Segue abaixo as respostas dissertativas propostas no teste.


## Understand the Industry

 1. **Explain the money flow and the information flow in the acquirer market and the role of the main players:**

    \
    O objetivo final do fluxo do dinheiro é simples, passar da conta do **cliente** para a conta do **comerciante**. Embora simples, este processo precisa que as **informações** e o **dinheiro** transitem por um fluxo seguro e definido, o que depende alguns **players** que tem seus **papéis** também definidos, conforme segue:

    \
    Primeiro o consumidor passa o cartão em uma maquininha, ou Ponto de venda, no estabelecimento do comerciante, sendo este o contratante dos serviços do banco adquirente.
    \
    O banco adquirente por sua vez faz as devidas verificações para garantir a segurança e a autencitidade da transação por parte do cliente, procedimento conhecido como Anti-fraude e autoriza ou não a transação. Caso autorizada mediante seus critérios de seguraça o adquirente irá solicitar a transação através da comunicação com a Rede de cartões que emitiu o cartão do cliente, por exemplo Visa ou Mastercard. Em caso de negativa, responde pelo ponto de venda que a transação no foi autorizada.
    \
    A Rede de cartões ao receber o comando de execução da transação fará a comunicação da mesma de forma segura ao banco emissor, de acordo com suas próprias regras e padrões para processamento do pedido.
    \
    O banco emissor, que é aquele que emitiu o cartão do cliente utilizado na transação é quem faz a verificação dos dados do cartão, se o cliente tem saldo disponível para aquela transação e, em caso positivo, fará a reserva do valor para posterior pagamento ao banco emissor.
    \
    Uma vez autorizada a liquidação da transação, o banco adquirente envia nova comunicação para a rede de cartões, que por sua vez procede com a transferência do valor do banco emissor para o banco adquirente, que por fim transfere o valor para a conta do comerciante, finalizando assim o fluxo.

    ##### Resumindo o fluxo da informação (caso de sucesso)
    1. Dados do cartão, cliente e venda são recebidos pelo ponto de venda;
    2. Ponto de venda envia as informações para o banco adquirente;
    3. Banco adquirente valida a segurança da transação e envia as informações à rede do cartão utilizado;
    4. A Rede de cartões envia as informações para o banco emissor;
    5. O Banco emissor verifica as informações e responde à Rede de cartões;
    6. A Rede de cartões recebe a resposta, executa a operação e responde ao banco adquirente;
    7. O Banco adquirente executa sua parte da operação e reponde ao comerciante através do ponto de venda.
    
    ##### Resumindo o fluxo do dinheiro (caso de sucesso)
    1. Após verificação das informações do cartão, do cliente e disponibilidade de saldo, o banco emissor reserva o valor solicitado na conta do cliente;
    2. A Rede de cartões transfere o valor do banco emissor para o banco adquirente
    3. O banco adquirente transfere o valor para a conta do comerciante

    ##### Resumindo os papéis dos players principais
    - Cliente: Consumidor final, portador de cartão utilizado como forma de pagamento, seu papél é consumir :)
    - Comerciante: Cliente do banco adquirente e portador do ponto de venda fornecido pelo adquirente por onde faz seus recebimentos. Cabe a ele proceder com as transaçẽos e receber por elas;
    - Adquirente: Intermediário responsável pela comunicação segura entre o comerciante e a Rede de cartões através do ponto de vandas, por fazer análise de risco e anti-fraude, por receber o valor da rede de cartões e rapassar ao comerciante;
    - Rede de cartões: Responsável pelas bandeiras dos cartões,  por comunicar a transação ao banco emissor e afetivar a transação entre o mesmo e o adquirente quando aprovada;
    - Emissor: Banco que emitiu o cartão, é quem detém a conta do consumidor. É o responsável por verificar os dados do cartão, o saldo do cliente, reservar o valor na conta do cliente e comunicar à rede de cartões;

    ##

 2. **Explain the difference between acquirer, sub-acquirer and payment gateway and how the flow explained in question 1 changes for these players:**

    A definição de Adquirente segue conforme dado na resposta acima, sendo o **Sub-adquirente** um player adicional no fluxo de pagamento, que tua antre o comerciante e o adquirente, provendo serviços extras que visam facilitar a aquisição de serviços de pagamentos para determinados nichos de mercados, como clientes de menor porte, por exemplo.
    \
    **Gateway de pagamento** por sua vez, também é um player que pode existir no fluxo e posiciona-se entre o comerciante e o adquirente, ou o sub-adquirente. Ele é quem otimiza e garante mais segurança no processo de cominucação entre estas partes do proceso, procedendo por exemplo com critptrafia e descriptografia dos dados trafegados e garantiro que os mesmos sejam transmitidos com a segurança e a formatação adequada, servindo portanto como uma ponte de comunicação no fluxo já estabelecido.
    \
    Basicamente o fluxo de com a entrada destes players fica assim: Cliente > Comerciante > Gateway de pagamentos > Sub-adquirente > Adquirente > Rede de cartões > Banco emissor
    
    ##


3. **Explain what chargebacks are, how they differ from cancellations and what is their connection with fraud in the acquiring world.**

    Chargeback é um procedimento geralmente iniciado pelo cliente, portador do cartão quando ele quer por exemplo, contextar uma compra não reconhecida, quando uma compra, geralmente não presencial não é entrege, ou é entregue de forma implempleta, danificada, etc. É um mecanismo que visa resguardar o cliente de quaisquer problemas que ele considere ter tido na operação. Os chargebacks são recebidos e pelo banco emissor, avalidados e se for procedente, o valor é devolvido ao titular do cartão.
    \
    Cancelamentos por sua vez são em geral ocorrem antes da liquidação final da operação, ou seja, antes da movimentação dos valores, por isso é um procedimento mais simples e menos burocrático, que pode aconter pode diversos motivos durante uma das etapas do fluxo previamente apresentado, como por exemplo por falta de saldo, demora ou erro de comunicação entre as partes e assim por diante.
    \
    Estes fatores estão diretamente ligados com as fraudes, tentativas de fraude e políticas anti-fraude que precisam existir durante todo o o mercado de adquirentes, a destacar os sequintes pontos:
    1. Chargebacks são ocorrências indesejáveis principalmente  para os comerciantes, pois no caso da confirmação de um chargeback o ônus tende a ficar com o comerciante. Para que isso seja evitado, devem ser tomados todos os cuidados possíveis para que uma transação fraudulenta não seja executada;
    2. No caso quando uma compra legítima é contextada, pode ocorrer também má fé do cliente, o que implicaria em uma devolução injusta do valor. Procedimentos de contextação de chargebacks, ou seja, a comprovação da inexistência da fraude se fazem necessários neste eco-sistema para garantir a confiabilidade do sistema de pagamentos como um todo.
    3. Sistemas anti-fraude portanto se mostram  extremamente importantes para todos os players no mercado de pagamentos, pois eles vão garantir segurança e confiabilidade do mercado como um todo.

## Get your hands dirty

Using this [**csv**](https://gist.github.com/cloudwalk-tests/76993838e65d7e0f988f40f1b1909c97#file-transactional-sample-csv) with hypothetical transactional data, imagine that you are trying to understand if there is any kind of suspicious behavior.

1. **Analyze the data provided and present your conclusions (consider that all transactions are made using a mobile device):**

    Considerando como principais fatores de risco os seguintes aspectos possíveis dentre os disponibilizados:
    1. Quantidade de cartões diferentes utilizados por um mesmo usuário;
    2. Quantidade aparelhos diferentes utilizados por um mesmo usuário;
    3. Quantidade de chargebacks prévios do usuário;

    Conclue-se que, dos 3.199 transações apresentadas 97 transações de apenas 5 usuários são extremamente suspeitas por se utilizarem de um número desproporcional de cartões diferentes e igualmente disrpoporcional número de chargebacks prévios, sendo estes os usuários: 11750, 91637, 79054, 96025 e 78262
    \
    Seguindo a análise formando uma espécie de score, podemos observar mais aproximadamente 47 usuários com atividade ainda suspeita, porém menos agressiva, por usarem mais de um cartão além de algum chargeback prévio;
    \
    Para além desses observa-se também um total de 830 transações sem device identificado, o que pode ser um sinal alerta quanto à confiabilidade da transação;
    ##

2. **In addition to the spreadsheet data, what other data would you look at to try to find patterns of possible frauds?**

    Podemos considerar os seguinte fatores adicionais para verificação de tentativa de fraude:
    1. Dados de geolocalização, como endereço de entrega para compras não presenciais em CEPs públicos, suspeitos ou em áreas de risco.
    2. Comparação do DDD com o cep, onde DDDs de cidades diferentes do cEP de entraga podem ser considerados suspeitos;
    3. Falta de informações cadastrais como telefone ou e-mail
    4. Comparação do IP da aparelho com DDD, CEP de destino, residência ou histórico de localização do cliente
    5. Quantidade de tentativas indicando procedimento de validação por força bruta
    6. Mudanças bruscas de comportamento de compra, como localização, valores, compras online e intervalo de compras
    7. Consultas a outras fontes financira de dados afim de verificar outros históricos de cancelamentos de cartões, inadimplências, etc.
    ##
    Entre outros...


## Solution App

Instruções para instalação e execução da aplicação que visa resolver o problema apresentado no enunciado do desafio, conforme a sessão 3.3 do **[Software Engineer - risk test](https://gist.github.com/cloudwalk-tests/76993838e65d7e0f988f40f1b1909c97#33---solve-the-problem)**

## README

- Instructions

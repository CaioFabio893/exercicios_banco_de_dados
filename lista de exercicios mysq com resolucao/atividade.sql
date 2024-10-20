#atividade 1 
SELECT 
    empregado.nome AS "Nome Empregado", 
    empregado.cpf AS "CPF Empregado",
    DATE_FORMAT(empregado.dataAdm, "%d/%m/%Y") AS "Data Admissão",
    CONCAT("R$ ", FORMAT(empregado.salario, 2, 'de_DE')) AS "Salário",
    departamento.nome AS "Departamento",
    telefone.numero AS "Número de Telefone"
FROM 
    empregado
LEFT JOIN departamento ON empregado.Departamento_idDepartamento = departamento.idDepartamento
INNER JOIN telefone ON empregado.cpf = telefone.Empregado_cpf
	WHERE empregado.dataAdm BETWEEN "2019-01-01" AND "2022-03-31"
		ORDER BY empregado.dataAdm DESC;
                
# atividade 2 

SELECT 
    empregado.nome as "Empregado", 
    empregado.cpf  "CPF Empregado",
	date_format (empregado.dataAdm, "%d/%m/%Y" ) "Data Adimissão",
    CONCAT("R$ ", FORMAT(empregado.salario, 2, 'de_DE')) AS "Salário",
    concat("R$ ", format(empregado.salario, 2, 'de_DE')) "Salário",
    departamento.nome "Departamento",
    telefone.numero "Número do telefone"
   
FROM 
    empregado
		left join departamento on empregado.Departamento_idDepartamento = departamento.idDepartamento
		left join telefone on empregado.cpf = telefone.Empregado_cpf
			where empregado.salario < (SELECT AVG(salario) FROM empregado)
				order by empregado.nome;
                
# atividade 3 

SELECT 
    departamento.nome AS "Departamento",
    COUNT(empregado.cpf)  "Quantidade de Empregados",
    CONCAT("R$ ", FORMAT(AVG(empregado.salario), 2, 'de_DE'))  "Média Salarial",
    CONCAT("R$ ", FORMAT(AVG(empregado.comissao), 2, 'de_DE'))  "Média da Comissão"
FROM 
    departamento
    LEFT JOIN empregado ON departamento.idDepartamento = empregado.Departamento_idDepartamento
		GROUP BY departamento.nome
			ORDER BY departamento.nome ASC;
            
#atividade 4 

SELECT 
    empregado.nome AS "Nome Empregado", 
    empregado.cpf "CPF Empregado",
    empregado.sexo  "Sexo",
    CONCAT("R$ ", FORMAT(empregado.salario, 2, 'de_DE'))  "Salário",
    COUNT(venda.idVenda)  "Quantidade Vendas",
    CONCAT("R$ ", FORMAT(SUM(venda.valor), 2, 'de_DE'))  "Total Valor Vendido",
    CONCAT("R$ ", FORMAT(SUM(venda.comissao), 2, 'de_DE'))  "Total Comissão das Vendas"
FROM 
    empregado
    LEFT JOIN venda ON empregado.cpf = venda.Empregado_cpf
		GROUP BY empregado.nome, empregado.cpf, empregado.sexo, empregado.salario
			ORDER BY COUNT(venda.idVenda) desc;

# atividade 5 

select
	empregado.nome as "Empregado",
    cpf "CPF empregado",
	empregado.sexo,
    CONCAT("R$ ", FORMAT(empregado.salario, 2, 'de_DE')) AS "Salário",
    quantidade,
	concat("R$ ", FORMAT(valor, 2 , 'de_De')) "Valor",
    concat("R$ ", FORMAT(comissao, 2 , 'de_De')) "Comissão",
    departamento.nome "Departamento",
    telefone.numero "Número do telefone"
    
FROM 
	servico
		LEFT JOIN itensservico ON servico.idServico = itensservico.Servico_idServico
		inner join empregado on itensservico.empregado_cpf = empregado.cpf
		left join departamento on empregado.Departamento_idDepartamento = departamento.idDepartamento
		left join telefone on empregado.cpf = telefone.Empregado_cpf
				order by quantidade;
                
#atividade 6

SELECT 
    pet.nome AS "Nome do PET",
    empregado.nome AS "Empregado",
    servico.nome AS "Serviço",
    quantidade AS "Quantidade de serviços",
    CONCAT("R$ ", FORMAT(venda.valor, 2, 'de_DE')) AS "Valor",
    DATE_FORMAT(venda.data, "%d/%m/%Y") AS "Data do Serviço"
FROM servico
    LEFT JOIN itensservico ON servico.idServico = itensservico.Servico_idServico
    INNER JOIN pet ON itensservico.pet_idpet = pet.idpet
    LEFT JOIN empregado ON itensservico.empregado_cpf = empregado.cpf
    LEFT JOIN venda ON itensservico.venda_idvenda = venda.idvenda
		ORDER BY venda.data ASC;
        
# atividade 7

select 
	cliente.nome "Cliente",
    DATE_FORMAT(venda.data, "%d/%m/%Y") AS "Data do Serviço",
    CONCAT("R$ ", FORMAT(venda.valor, 2, 'de_DE')) AS "Valor",
    CONCAT("R$ ", FORMAT(venda.desconto, 2, 'de_DE')) AS "Desconto",
	concat('R$ ', format(venda.valor - venda.desconto, 2, 'de_DE')) "Valor Final",
    empregado.nome "Empregado"
    
from venda
	left join cliente on venda.cliente_cpf = cliente.cpf
    left join empregado on venda.Empregado_cpf = empregado.cpf
		order by venda.data asc;
    
#atividade 8 

select 
	servico.nome "Nome do Serviço",
	quantidade "Vendas Por Serviço",
    concat('R$ ', format((venda.valor + servico.valorVenda) * quantidade , 2, 'de_DE')) "Valor Final"
    
from servico
	LEFT JOIN itensservico ON servico.idServico = itensservico.Servico_idServico
    inner JOIN venda ON itensservico.venda_idvenda = venda.idvenda
		order by quantidade desc
			limit 10;
            
#atividade 9

SELECT 
    formapgvenda.tipo AS "Tipo Forma Pagamento",
    COUNT(venda.idvenda) AS "Quantidade Vendas",
    CONCAT('R$ ', FORMAT(SUM(formapgvenda.valorPago), 2, 'de_DE')) AS "Total Valor Vendido"
FROM formapgvenda
	LEFT JOIN venda ON formapgvenda.venda_idvenda = venda.idvenda
		GROUP BY formapgvenda.tipo
			ORDER BY COUNT(venda.idvenda) DESC;
            
#atividade 10 

SELECT 
	date_format(venda.data, "%d/%m/%Y") AS "Data Venda",
    COUNT(venda.idvenda) AS "Quantidade de Vendas",
    CONCAT('R$ ', FORMAT(SUM(formapgvenda.valorPago), 2, 'de_DE')) AS "Valor Total Venda"
FROM venda
	LEFT JOIN formapgvenda ON venda.idvenda = formapgvenda.venda_idvenda
		GROUP BY venda.data
			ORDER BY venda.data DESC;

#atividade 11

SELECT 
	produtos.nome as "Nome do Produto",
    concat("R$ ", format(itenscompra.valorcompra, 2, 'de_DE')) "Valor do Produto",
    FORMAT(itenscompra.quantidade, 0, 'de_DE') AS "Quantidade",
    fornecedor.nome"Nome Fornecedor",
    telefone.numero "Número do Fornecedor",
    fornecedor.email "email forcenedor"
from produtos
	LEFT JOIN itenscompra ON produtos.idproduto = itenscompra.produtos_idproduto
    left join compras on itenscompra.Compras_idCompra = compras.idCompra
    left join fornecedor on compras.Fornecedor_cpf_cnpj = fornecedor.cpf_cnpj
    left join telefone on fornecedor.cpf_cnpj = telefone.Fornecedor_cpf_cnpj
			ORDER BY produtos.nome;
    
# atividade 12
SELECT 
    produtos.nome AS "Nome Produto",
    COUNT(itensvendaprod.Produto_idProduto) AS "Quantidade (Total) Vendas",
    CONCAT('R$ ', FORMAT(SUM(itensvendaprod.valor), 2, 'de_DE')) AS "Valor Total Recebido pela Venda do Produto"
FROM produtos
	LEFT JOIN itensvendaprod ON produtos.idProduto = itensvendaprod.Produto_idProduto
		GROUP BY produtos.nome
			ORDER BY COUNT(itensvendaprod.Produto_idProduto) DESC;
    




	
   







	
   



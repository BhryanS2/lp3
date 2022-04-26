<?php
require_once 'PessoaFisica.php';
$PessoaFisicaObj = new PessoaFisica();
$PessoaFisicaObj->setNome('João');
$PessoaFisicaObj->setEndereco('Rua das Flores');
$PessoaFisicaObj->setTelefone('(11) 99999-9999');
$PessoaFisicaObj->setEmail('joao@gmail.com');
$PessoaFisicaObj->setIdade(25);
$PessoaFisicaObj->setCPF('123.456.789-10');
$PessoaFisicaObj->setRG('123456789');
$PessoaFisicaObj->setDataNascimento('25/04/1990');
echo 'Nome: ' . $PessoaFisicaObj->getNome() . '<br>';
echo 'Endereço: ' . $PessoaFisicaObj->getEndereco() . '<br>';
echo 'Telefone: ' . $PessoaFisicaObj->getTelefone() . '<br>';
echo 'Email: ' . $PessoaFisicaObj->getEmail() . '<br>';
echo 'Idade: ' . $PessoaFisicaObj->getIdade() . '<br>';
echo 'CPF: ' . $PessoaFisicaObj->getCPF() . '<br>';
echo 'RG: ' . $PessoaFisicaObj->getRG() . '<br>';
echo 'Data de Nascimento: ' . $PessoaFisicaObj->getDataNascimento() . '<br>';

// Pessoa normal
$PessoaObj = new Pessoa();
$PessoaObj->setNome('Teste');
$PessoaObj->setEndereco('Rua das dores');
$PessoaObj->setTelefone('(11) 99999-9999');
$PessoaObj->setEmail('teste@gmail.com');
echo 'Nome: ' . $PessoaObj->getNome() . '<br>';
echo 'Endereço: ' . $PessoaObj->getEndereco() . '<br>';
echo 'Telefone: ' . $PessoaObj->getTelefone() . '<br>';
echo 'Email: ' . $PessoaObj->getEmail() . '<br>';

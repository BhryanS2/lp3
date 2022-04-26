<?php
require 'Animal.php';
$AnimalObj = new Animal();
$AnimalObj->setNome('Totó');
$AnimalObj->setCor('Amarelo');
$AnimalObj->setIdade(2);

echo 'Nome: ' . $AnimalObj->getNome() . '<br>';
echo 'Cor: ' . $AnimalObj->getCor() . '<br>';
echo 'Idade: ' . $AnimalObj->getIdade() . '<br>';

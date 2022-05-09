<?php
require_once './Cachorro.php';
require_once './Animal.php';

$cachorro = new Cachorro("Bobby", 2, 10, "Poodle", "Amarelo", "Pequeno");

echo "Nome: " . $cachorro->getNome() . "<br>";
echo "Idade: " . $cachorro->getIdade() . "<br>";
echo "Peso: " . $cachorro->getPeso() . "<br>";
echo "Raça: " . $cachorro->getRaca() . "<br>";
echo "Cor: " . $cachorro->getCor() . "<br>";
echo "Tamanho: " . $cachorro->getTamanho() . "<br>";
echo "CONSTANTE Tempo de vida: " . Cachorro::TEMPO_DE_VIDA . "<br>";
echo "CONSTANTE Casa: " . Cachorro::CASA . "<br>";

echo "<br>";

$animal = new Animal("Rex", 1, 20);

echo "Nome: " . $animal->getNome() . "<br>";
echo "Idade: " . $animal->getIdade() . "<br>";
echo "Peso: " . $animal->getPeso() . "<br>";
echo "CONSTANTE Casa: " . Animal::CASA . "<br>";

#!/bin/bash

# Lê os dados de entrada do POST
read POST_DATA

# Extrai os valores dos números e da operação escolhida
NUM1=$(echo "$POST_DATA" | sed 's/.*num1=\([^&]*\).*/\1/' | sed 's/+/ /g' | sed 's/%20/ /g')
NUM2=$(echo "$POST_DATA" | sed 's/.*num2=\([^&]*\).*/\1/' | sed 's/+/ /g' | sed 's/%20/ /g')
OPERATION=$(echo "$POST_DATA" | sed 's/.*operation=\([^&]*\).*/\1/')

# Verifica se os valores numéricos são válidos (não vazios e números)
if [[ -z "$NUM1" || -z "$NUM2" || ! "$NUM1" =~ ^-?[0-9]+([.][0-9]+)?$ || ! "$NUM2" =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
    RESULT="Erro: Insira números válidos."
else
    # Executa a operação selecionada
    case $OPERATION in
        add)
            RESULT=$(echo "$NUM1 + $NUM2" | bc)
            ;;
        subtract)
            RESULT=$(echo "$NUM1 - $NUM2" | bc)
            ;;
        multiply)
            RESULT=$(echo "$NUM1 * $NUM2" | bc)
            ;;
        divide)
            if [[ "$NUM2" == "0" ]]; then
                RESULT="Erro: Divisão por zero não é permitida."
            else
                RESULT=$(echo "scale=2; $NUM1 / $NUM2" | bc)
            fi
            ;;
        *)
            RESULT="Erro: Operação inválida."
            ;;
    esac
fi

# Cabeçalho HTTP para resposta HTML
echo "Content-type: text/html"
echo ""

# Exibe o resultado em HTML
echo "<!DOCTYPE html>"
echo "<html lang='pt-br'>"
echo "<head>"
echo "    <meta charset='UTF-8'>"
echo "    <title>Resultado da Calculadora</title>"
echo "</head>"
echo "<body>"
echo "    <h1>Resultado</h1>"
echo "    <p>$RESULT</p>"
echo "    <a href='/calculadora.html'>Voltar à calculadora</a>"
echo "</body>"
echo "</html>"

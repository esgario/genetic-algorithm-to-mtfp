# Genetic Algorithms to the Multiple Team Formation Problem

Código desenvolvido em MATLAB para resolver o problema de alocação de recursos humanos em múltiplos times levando em contao fator sociométrico.

### Prerequisites

MATLAB 2015a ou superior.

* É bem possível que funcione em versões anteriores mas pode haver conflitos de nomes de funções ou a não existência de alguma função específica utilizada neste projeto.

## Running the tests

Para executar o código basta abrir o arquivo **Main.m** no seu MATLAB e executá-lo.

A variável **dataset** pode ser modificada para selecionar um dos sete datasets desenvolvidos para o trabalho.

O retorno no console é apresentado como

**Fitness, Cohesion and Penalty**

Onde o valor da **Fitness = Cohesion - Penalty**

**Cohesion** é a coesão dos grupos.
**Penalty** é uma medida de penalidade que mensura o quanto as restrições são infringidas.
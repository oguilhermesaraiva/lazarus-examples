# Projeto POO – Dispositivos Elétricos em Lazarus/FPC
Este projeto demonstra, de forma simples e prática, diversos conceitos **fundamentais da Programação Orientada a Objetos (POO)** usando [**FPC 3.3.1**][fpc] & [**Lazarus 4.99**][laz].

Ele foi construído com uma **interface** e quatro **objetos** que representam dispositivos elétricos:

* `TAppliance` Classe mãe abstrata (Eletrodoméstico)  
* `TLightingFixture` Classe filha  (Luminária)
* `TFan` Classe filha (Ventilador)
* `TElectricalOutlet` Classe (Tomada) 
* `IPlug` Interface (Contrato Tomada) 

E um formulário principal (**FormMain**) que permite instanciar e manipular esses objetos através de botões.

## 🎯 Objetivo
Este projeto tem como objetivo ensinar conceitos fundamentais de POO para iniciantes, mostrando na prática como:

* Fazer uma **classe mãe abstrata**
* Fazer **classes filhas** que herdam comportamento
* Usar **polimorfismo**
* Aplicar **herança**
* Trabalhar com **interface**
* Usar métodos **virtuais/abstratos**
* Trabalhar com **encapsulamento**
* Organizar o código em **unidades (units)**

## 🧱 Arquitetura do Projeto

```
📂 src
 ├── uElectricalOutlet.pas
 ├── uLightingFixture.pas
 ├── uFan.pas
 └── view.FormMain.pas
```
Cada arquivo representa uma classe ou parte do sistema visual.

## 🧠 Principais Conceitos de POO Usados no Projeto

A seguir, uma explicação detalhada de cada conceito aplicado no código.

### 1. **Classes**

Uma *classe* é um modelo, uma “forma” de onde os objetos são criados.

Classe mãe:

```pascal
type
  TAppliance = class abstract
```

Classes filhas:

```pascal
type
  TLightingFixture = class(TAppliance)
  {...}
  TFan = class(TAppliance)
  {...}
```

### 2. **Objetos**

Objetos são instâncias de classes. Eles são criados em tempo de execução.

No ``FormMain``:

```pascal
FAppliance := TLightingFixture.Create;
```

### 3. **Encapsulamento**

Encapsulamento protege dados internos do objeto usando:

* ``private``
* ``protected``
* ``public``

Exemplo:

```pascal
private
FOnOff: boolean;
```
Somente a própria classe onde foi declarado pode acessar.

```pascal
protected
FPlug: IPlug;
```
Somente a classe declarante, suas subclasses (que herdam dela) e outras classes dentro do mesmo pacote.

```pascal
public
procedure ResetState; override;
```
Qualquer classe, em qualquer lugar pode acessar.

### 4. **Herança**

Uma classe filha herda todos os atributos e comportamentos da 
classe mãe:

```pascal
type
  TLightingFixture = class(TAppliance)
```

Benefícios:

* Reduz duplicação
* Torna o código organizado
* Facilita manutenção e escalabilidade

### 5. **Polimorfismo**

Polimorfismo permite que classes diferentes respondam de forma diferente ao mesmo método.

A classe mãe define:

```pascal
function StatusMessage: string; virtual; abstract;
```

Cada classe filha fornece sua própria implementação:

#### Luminária

```pascal
function TLightingFixture.StatusMessage: string;
begin
  if Working then
    Result := 'A luminária está LIGADA!'
  else
    Result := 'A luminária está DESLIGADA.';
end;
```

#### Ventilador

```pascal
function TFan.StatusMessage: string;
begin
  if Working then
    Result := Format('O ventilador está funcionando na velocidade: %s', [FSpeed.ToString])
  else
    Result := Format('O ventilador NÃO está funcionando. Velocidade: %s', [FSpeed.ToString]);
end;  
```

### 6. **Classe Abstrata**

Uma classe abstrata não pode ser instanciada.

```pascal
TElectricalDevice = class abstract
```

Ela serve como modelo para as classes filhas.

### 7. **Métodos Virtuais e Override**

* [``virtual``][objfpc] → pode ser sobrescrito
* [``abstract``][objfpc] → deve ser sobrescrito
* [``override``][objfpc] → substitui uma implementação herdada
* [``overload``][objfpc] → sobrescreve uma implementação

Exemplo:
#### virtual e abstract

```pascal
function ExempleFunc: string; virtual; abstract;
```

#### override

```pascal
function ExempleFunc: string; override;
```

#### overload

```pascal
function ExempleFunc: string; overload;
```

### 8. **Units e Organização**

Cada classe do projeto está em sua própria unit:

* ``uFan.pas``

* ``uLightingFixture.pas``

* ``uElectricalOutlet.pas``

E o formulário usa essas units:

```pascal
uses
  uElectricalOutlet, uLightingFixture, uFan;
```
### 🖥️ Funcionamento do Formulário

O usuário seleciona os botões que instanciam e conectam na tomada os objetos:

```pascal
Appliance := TFan.Create;
ShowMessage(Device.StatusMessage);
```

Isso demonstra:

* criação de objetos
* polimorfismo
* comportamento específico de cada classe

## 📘 Fluxo Geral do Sistema

1. O usuário seleciona um botão radio (Ventilador, Luminária, etc.)
2. O sistema cria um objeto da classe correspondente
3. A classe filha implementa seu comportamento próprio
4. O formulário exibe o resultado usando polimorfismo

## 🧪 Como testar

1. Abra o projeto no **Lazarus**
2. Compile e execute
3. Clique nos botões radio para instanciar diferentes objetos
4. Observe mensagens e comportamentos distintos

## 🎓 Conclusão

Este projeto demonstra de forma simples, como:

* organizar classes
* usar herança
* usar interface
* aplicar polimorfismo
* encapsular estados
* estruturar um programa orientado a objetos em Pascal

É um ótimo ponto de partida para quem deseja dominar POO em [**FPC**][fpc] / [**Lazarus**][laz].

Projeto POO – Dispositivos Elétricos em Lazarus/FPC.

Copyright (C) 2025 by Guilherme Saraiva.

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, see https://www.gnu.org/licenses/.

[laz]: https://www.lazarus-ide.org/
[fpc]: https://www.freepascal.org/
[objfpc]: https://castle-engine.io/modern_pascal
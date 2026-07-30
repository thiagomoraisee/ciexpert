# Sequential Accumulator in SystemVerilog

## Análise da Simulação

1. Compare as formas de onda obtidas no Verdi com os valores impressos pelo testbench. Eles são consistentes? Gere evidências com prints de que isso é verdade.
```
LOAD 20 --> [ACC = 20]
ADD 5 --> [ACC = 25]
SUB 10 --> [ACC = 15]
HOLD --> [ACC = 15]
DISABLE --> [ACC = 15]
LOAD 100 --> [ACC = 100]
$finish called from file "tb/accumulator_tb.sv", line 89.
$finish at simulation time               106000
```

2. Em que instante o reset deixa de atuar sobre o circuito?
3. Quantos ciclos de clock são necessários para que uma operação seja efetivamente refletida na saída?
4. O valor da saída muda quando `enable = 0`? Justifique.


## Synthesis Analysis

1. Qual é a área total ocupada pelo circuito após a síntese?
Total area: 182.628618 um2

2. Qual é o caminho crítico identificado pelo relatório de timing?

Entre a entrada do circuito `op` e a entrada D do flip-flop `acc_reg`. No pior caso temos o caminho crítico que começa em `op[0]` e termina em `acc_reg[7]`

3. Por quais elementos do circuito o caminho crítico passa?

```
  op[0] (in)                               0.00       1.00 f
  U18/Y (INVX0_RVT)                        0.03       1.03 r
  U19/Y (INVX0_RVT)                        0.05       1.09 f
  U27/Y (XOR2X1_RVT)                       0.11       1.19 r
  U46/CO (FADDX1_RVT)                      0.10       1.29 r
  U44/CO (FADDX1_RVT)                      0.09       1.37 r
  U42/CO (FADDX1_RVT)                      0.09       1.46 r
  U40/CO (FADDX1_RVT)                      0.09       1.55 r
  U38/CO (FADDX1_RVT)                      0.09       1.63 r
  U36/CO (FADDX1_RVT)                      0.08       1.72 r
  U31/Y (XOR2X1_RVT)                       0.06       1.78 r
  U35/Y (AO222X1_RVT)                      0.09       1.87 r
  acc_reg[7]/D (DFFX1_RVT)                 0.01       1.88 r
```

Saindo da entrada, passa por 2 INV, 2 XOR e 5 FULL ADDERS até chegar na porta D do flip-flop `acc_reg`.

4. Existem violações de setup ou hold? Caso existam, em quais condições elas ocorrem?

``` setup_violations.rpt
This design has no violated constraints.
```
Não há violações de setup/hold.

5. Qual é a potência estimada do circuito?

```power.rpt
                 Internal         Switching           Leakage            Total
Power Group      Power            Power               Power              Power   (   %    )  Attrs
--------------------------------------------------------------------------------------------------
io_pad             0.0000            0.0000            0.0000            0.0000  (   0.00%)
memory             0.0000            0.0000            0.0000            0.0000  (   0.00%)
black_box          0.0000            0.0000            0.0000            0.0000  (   0.00%)
clock_network      6.3623            0.0000            0.0000            6.3623  (  24.61%)  i
register           0.2865            0.1311        8.6874e+06            9.1049  (  35.21%)
sequential         0.0000            0.0000            0.0000            0.0000  (   0.00%)
combinational      1.7872            0.5653        8.0380e+06           10.3905  (  40.18%)
--------------------------------------------------------------------------------------------------
Total              8.4360 uW         0.6964 uW     1.6725e+07 pW        25.8577 uW
```

P_TOT = 25.8577 uW

6. Qual é a contribuição relativa dos flip-flops e da lógica combinacional para a área total?

```area_pos.rpt
Combinational area:                116.906239
Buf/Inv area:                        5.082880
Noncombinational area:              52.861954
Macro/Black Box area:                0.000000
Net Interconnect area:              12.860425

Total cell area:                   169.768193
Total area:                        182.628618
```

Sequential = Noncombinational area = 52.861954 um2
Total area =  182.628618 um2

Area relativa FF = 52.861954/182.628618 = 28.94 %

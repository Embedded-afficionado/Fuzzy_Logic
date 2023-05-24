%1° Trabalho de inteligência artificial
%João Gabriel Fernandes Gomes ->418270

% Construa um programa baseado em lógica fuzzy conforme as regras disponibilizadas na
% Seção 18.9 (Sistema para recomendar dose de quinino) do livro “Inteligência Artificial”,
% Ben Coppin; LTC, 2010. O programa deverá solicitar as entradas ao usuário e exibir a
% saída produzida. Obs. 1 – na Regra 3, executar o operador lógico OU antes do E. 2 –
% Não usar aplicações que realizem diretamente a tarefa, como, por exemplo, o Fuzzy
% Logic Designer do MATLAB.s

%Garante os valores requisitados
temperatura = input("Digite o valor da temperatura: (0° a 100°)\n"); %T
while(temperatura>100 || temperatura<0)
    temperatura = input("Valores são apenas válidos entre 0° e 100°\n"); %T
end

umidade = input("Digite o valor da umidade:\n"); %U
while(umidade>100 || umidade<0)
    umidade = input("Valores são apenas válidos entre 0kg/m³ e 100kg/m³ \n");
end

proximidade_agua = input("Digite o valor da proximidade_agua:\n"); %P
while(proximidade_agua>50 || proximidade_agua<0)
    proximidade_agua = input("Valores são apenas válidos entre 0km e 50km\n");
end

industrializacao = input("Digite o valor da industrialização:\n"); %I
while(industrializacao>100 || industrializacao<0)
    industrializacao = input("Valores são apenas válidos entre os indices industriais 0 e 100\n");
end
%Fim de inputs de usuário

%Variáveis do centroide
controladora_somatorio = 5; %Valores de 5 a 100
k = 1;

%Definição de PtA -> Página 453 do livro
if(temperatura>=25)
    Pertinencia_temperatura_alta = (temperatura-25)/75;
    fprintf("Grau de pertencimento a Temperatura alta:\n%.3f\n",Pertinencia_temperatura_alta);
else
    if(temperatura<25)
    Pertinencia_temperatura_alta = 0;
    fprintf("Grau de pertencimento a temperaturas altas:\n%.3f\n",Pertinencia_temperatura_alta);
    end
end

%Definição de PtB -> Página 454 do livro
if(temperatura<=75)
    Pertinencia_temperatura_baixa = (1-(temperatura/75));
    fprintf("Grau de pertencimento a temperaturas baixas: \n%.3f\n",Pertinencia_temperatura_baixa);
else
    if(temperatura>75)
        Pertinencia_temperatura_baixa = 0;
        fprintf("Grau de pertencimento a temperaturas baixas: \n%.\n",Pertinencia_temperatura_baixa);
    end
end

%Definição de PuA e PuB -> Página 454 do livro
Pertinencia_umidade_alta = umidade/100;
fprintf("Grau de pertencimento a umidades altas:\n%.3f\n",Pertinencia_umidade_alta);
Pertinencia_umidade_baixa = 1-(umidade/100);
fprintf("Grau de pertencimento a umidades baixas:\n%.3f\n",Pertinencia_umidade_baixa);

%Definição de PpP e PpL -> Página 454 do livro
%Definição de PpP (Proximidades proximas a agua)
if(proximidade_agua<10)
    Pertinencia_proximidade_perto_agua = 1;
    fprintf("Grau de pertencimento a distancias proximas:\n%.3f\n",Pertinencia_proximidade_perto_agua);
else
    if(proximidade_agua>=10 && proximidade_agua<40)
        Pertinencia_proximidade_perto_agua = (40-proximidade_agua)/30;
        fprintf("Grau de pertencimento a distancias proximas:\n%.3f\n",Pertinencia_proximidade_perto_agua);
    end
    if(proximidade_agua>=40)
        Pertinencia_proximidade_perto_agua = 0;
        fprintf("Grau de pertencimento a distancias proximas:\n%.3f\n",Pertinencia_proximidade_perto_agua);
    end
end

%Definição de PpL(Proximidade longas a agua)
if(proximidade_agua<10)
    PpL = 0;
    fprintf("Grau de pertencimento a distancias Longas(<10):\n%.3f\n",PpL);
else
    if(proximidade_agua>=10 && proximidade_agua<40)
        PpL = (proximidade_agua-10)/30;
        fprintf("Grau de pertencimento a distancias Longas(10 e 40):\n%.3f\n",PpL);
    end
    if(proximidade_agua>=40)
        PpL = 1;
        fprintf("Grau de pertencimento a distancias Longas(>40):\n%.3f\n",PpL);
    end
end

%Definição PiA e PiB -> Página 454 do livro
%PiA (industrialização alta)
if(industrializacao<10)
    Pertinencia_industrializacao_alta = 0;
    fprintf("Grau de pertencimento a alta industrialização:\n%.3f\n",Pertinencia_industrializacao_alta);
else
    if(industrializacao>=10 && industrializacao<20)
        Pertinencia_industrializacao_alta = (industrializacao-10)/10;
        fprintf("Grau de pertencimento a alta industrialização:\n%.3f\n",Pertinencia_industrializacao_alta);
    end
    if(industrializacao>=20)
        Pertinencia_industrializacao_alta = 1;
        fprintf("Grau de pertencimento a alta industrialização:\n%.3f\n",Pertinencia_industrializacao_alta);
    end
end

%PiB(industrialização baixa)
if(industrializacao<10)
    Pertinencia_industrializacao_baixa= 1;
    fprintf("Grau de pertencimento a baixa industrialização:\n%.3f\n",Pertinencia_industrializacao_baixa);
else
    if(industrializacao>=10 && industrializacao<20)
        Pertinencia_industrializacao_baixa = (20-industrializacao)/10;
        fprintf("Grau de pertencimento a baixa industrialização:\n%.3f\n",Pertinencia_industrializacao_baixa);
    end
    if(industrializacao>=20)
        Pertinencia_industrializacao_baixa = 0;
        fprintf("Grau de pertencimento a baixa industrialização:\n%.3f\n\n",Pertinencia_industrializacao_baixa);
    end
end

%Possíveis doses de Quinino -> PqM(muito baixa) PqB(Baixa) e PqA(Alta)
vetorMestre =[Pertinencia_temperatura_alta,Pertinencia_temperatura_baixa,Pertinencia_umidade_alta,Pertinencia_umidade_baixa,Pertinencia_proximidade_perto_agua,PpL,Pertinencia_industrializacao_alta,Pertinencia_industrializacao_baixa];
vetor1 = [Pertinencia_temperatura_alta,Pertinencia_umidade_alta,Pertinencia_industrializacao_baixa,Pertinencia_proximidade_perto_agua]; %Serve para regra 1 
vetor3 = [Pertinencia_temperatura_alta,Pertinencia_umidade_alta,Pertinencia_industrializacao_baixa]; %Serve para a regra 3
%regra 1, dose alta de quinino

Quinino_dosagem_alta = min(vetor1);
fprintf("Dose alta de quinino:\n%.3f\n",Quinino_dosagem_alta);

%regra2, dose baixa de quinino
Quinino_dosagem_baixa = Pertinencia_industrializacao_alta;
fprintf	("Dose baixa de quinino:\n%.3f\n",Quinino_dosagem_baixa);

%regra3, dose alta de quinino
Quinino_Dosagem_alta_Regra3 = max(vetor1(:,3),vetor1(:,4));
Quinino_Dosagem_alta_Regra3 = min(Quinino_Dosagem_alta_Regra3, vetor1(:,1:2));
Quinino_Dosagem_alta_Regra3 = min(Quinino_Dosagem_alta_Regra3);

fprintf	("Dose alta(regra3) de quinino:\n%.3f\n",Quinino_Dosagem_alta_Regra3);

% Regra 4, dose muito baixa

Quinino_dosagem_muito_baixa = min(Pertinencia_temperatura_baixa,Pertinencia_umidade_baixa);
fprintf	("Dose Muito baixa:\n%.3f\n",Quinino_dosagem_muito_baixa);

Quinino_dosagem_alta_total = max(Quinino_dosagem_alta,Quinino_Dosagem_alta_Regra3);

%Funções de pertinência do Quinino

%PqM = pertinência Quinino Muito Baixa
if(Quinino_dosagem_muito_baixa<=10)
    Pertinencia_quinino_muito_baixa = (10-Quinino_dosagem_muito_baixa)/10;
else
    if(Quinino_dosagem_muito_baixa>10)
        Pertinencia_quinino_muito_baixa = 0;
    end
end

%Pertinência Quinino Baixa
if(Quinino_dosagem_baixa<=50)
    Pertinencia_quinino_baixa=(50-Quinino_dosagem_baixa)/50;
else
    if(Quinino_dosagem_baixa>50)
        Pertinencia_quinino_baixa = 0;
    end
end

%Pertinência Quinino Alta
if(Quinino_dosagem_alta<=40)
    Pertinencia_quinino_alta = 0;
else
    if(Quinino_dosagem_alta>40)
        Pertinencia_quinino_alta = (Quinino_dosagem_alta - 40)/60;
    end
end

%Pertinência Quinino Alta regra 3
if(Quinino_Dosagem_alta_Regra3<=40)
    Pertinencia_quinino_alta_regra3 = 0;
else
    if(Quinino_Dosagem_alta_Regra3>40)
        Pertinencia_quinino_alta_regra3 = (Quinino_Dosagem_alta_Regra3 - 40)/60;
    end
end

%Pertinência Quinino_dosagem_alta_total
if(Quinino_dosagem_alta_total<=40)
    Pertinencia_quinino_alta_total = 0;
else
    if(Quinino_dosagem_alta_total>40)
        Pertinencia_quinino_alta_total = (Quinino_dosagem_alta_total - 40)/60;
    end
end
% 
% disp(Pertinencia_quinino_muito_baixa);
% disp(Pertinencia_quinino_baixa);
% disp(max(Pertinencia_quinino_alta_regra3,Pertinencia_quinino_alta));
 fprintf("Dosagem total das regras altas\n%.3f\n\n",Quinino_dosagem_alta_total);

%Centroide -> Rascunho
%fprintf	("\n\n\nQuinino dose muito baixa:\n%.3f\nQuinino dose Baixa:\n%.3f\nQuinino dose Alta:\n%.3f\n",Quinino_dosagem_muito_baixa,Quinino_dosagem_baixa,Quinino_dosagem_alta_total);
 
vetor_dedutor_dos_limites = [Quinino_dosagem_alta_total Quinino_dosagem_baixa Quinino_dosagem_muito_baixa];
%dosagem_baixa_unida = max(Quinino_dosagem_muito_baixa,Quinino_dosagem_baixa);

Pax = zeros(1,20);
Paxx = 0;

while(controladora_somatorio<=100)
 
    if(controladora_somatorio<=10 || controladora_somatorio>10 && controladora_somatorio<=40)
         competicao_somatorio = (10-controladora_somatorio)/10;
         comparadora1 = min(competicao_somatorio,Quinino_dosagem_muito_baixa);  %valor fixo de 0.1(viajante 1)
         competicao_somatorio2 =(50-controladora_somatorio)/50;
         comparadora2 = min(competicao_somatorio2,Quinino_dosagem_baixa); %valor fixo de 
         competicao_somatorio = max(comparadora2,comparadora1);

    else
        if(controladora_somatorio>40 && controladora_somatorio<=50)
            competicao_somatorio = (controladora_somatorio-40)/60;
            comparadora1 = min(competicao_somatorio,Quinino_dosagem_alta_total);
            competicao_somatorio2 = (50-controladora_somatorio)/50;
            comparadora2 = min(competicao_somatorio2,Quinino_dosagem_baixa);
            competicao_somatorio = max(comparadora1,comparadora2);
        else
            if(controladora_somatorio>50)
                competicao_somatorio = (controladora_somatorio-40)/60; 
                comparadora1 = min(competicao_somatorio,Quinino_dosagem_alta_total);
                competicao_somatorio = min(competicao_somatorio,Quinino_dosagem_alta_total);
            end
        end
    end
    Paxx = Paxx + competicao_somatorio;
    Pax(:,k) =  competicao_somatorio * controladora_somatorio;
    k = k+1;
    controladora_somatorio = controladora_somatorio+5;

end
fprintf("Sua saída desnebulizada eh:%.4f\n",sum(Pax)/Paxx);

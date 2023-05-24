
% João Gabriel Fernandes Gomes -  418270

% QUESTÃO 01
% Construa um programa baseado em lógica fuzzy (inferência de Mamdani) conforme
% as regras disponibilizadas no Exercício 18 do livro "Inteligência Computacional
% Aplicada à Administração, Economia e Engenharia em Matlab", Hime Aguiar e
% Oliveira Jussnior (Coordenadores), Caldeira, A. M.; Machado, M. A. S.; Sousa, R. C.;
% Tanscheit, R.; Thomson Learnings, 2007.
% O programa deverá solicitar as entradas ao usuário e exibir a saída produzida. (4,0 pontos)

printf("\n");
temperatura = input("Digite a temperatura ambiente (15 °C a 45 °C): ");

preco = input("Digite o preço unitário (1 $ a 6 $): ");

if (temperatura >= 15 && temperatura <= 45 && preco >= 1 && preco <= 6)

    % Temperatura (baixa, média, alta)
       % função gaussiana
    % Temperatura baixa
    
    numTB = -(15-temperatura).^2;
    denTB = 2 * (6.369).^2;
    temperaturaBaixa = exp(numTB./denTB);
    
    % Temperatura média
    
    numTM = -(30-temperatura).^2;
    denTM = 2 * (6.369).^2;
    temperaturaMedia = exp(numTM./denTM);
    
    % Temperatura alta
    
    numTA = -(45-temperatura).^2;
    denTA = 2 * (6.369).^2;
    temperaturaAlto = exp(numTA./denTA);
    
    % Preço (baixo, médio, alto)
       % função gaussiana
    % Preço baixo
    
    numPB = -(1-preco).^2;
    denPB = 2 * (1.061).^2;
    precoBaixo = exp(numPB./denPB);
    
    % Preço medio
    
    numPM = -(3.5-preco).^2;    % O valor dado na questão do livro era 3.05, mas como observado e depois confirmado com o professor o valor correto é 3.5
    denPM = 2 * (1.061).^2;
    precoMedio = exp(numPM./denPM);
    
    % Preço alto
    
    numPA = -(6-preco).^2;
    denPA = 2 * (1.061).^2;
    precoAlto = exp(numPA./denPA);
    
    reg1 = min(temperaturaBaixa, precoBaixo); % regra 1
    reg2 = min(temperaturaBaixa, precoMedio); % regra 2
    reg3 = min(temperaturaBaixa, precoAlto); % regra 3
    reg4 = min(temperaturaMedia, precoBaixo); % regra 4
    reg5 = min(temperaturaMedia, precoMedio); % regra 5
    reg6 = min(temperaturaMedia, precoAlto); % regra 6
    reg7 = min(temperaturaAlto, precoBaixo); % regra 7
    reg8 = min(temperaturaAlto, precoMedio); % regra 8
    reg9 = min(temperaturaAlto, precoAlto); % regra 9
    
    cg = [reg1 reg4 reg7]; 
    consumoGranderegras = max(cg);
    
    cm = [reg2 reg5 reg8];
    consumoMedioregras = max(cm);
    
    cp = [reg3 reg6 reg9];
    consumoPequenoregras = max(cp);
    
    v = ones(1,6000);
    % 3 FOR para preenchimento do vetor com os valores pra consumo grande, médio ou pequeno
    for i = 500:6000 
       valor = min(consumoGranderegras, max(min((i-3250)/(6000-3250),(8750-i)/(8750-6000)),0)); % mínimo entre consumo grande pelas regras e consumo grande pela função triangular
       v(i) = valor;
    end
    
    for i = 500:6000 
        valor = min(consumoMedioregras, max(min((i-500)/(3250-500),(6000-i)/(6000-3250)),0));   % mínimo entre consumo médio pelas regras e consumo médio pela função triangular
        mm = max(valor,v(i));
        v(i) = mm;
    end
    
    for i = 500:6000 
       valor = min(consumoPequenoregras, max(min((i-(-2250))/(500-(-2250)),(3250-i)/(3250-500)),0));% mínimo entre consumo pequeno pelas regras e consumo pequeno pela função triangular
       mm = max(valor,v(i));
       v(i) = mm;
    end
    
    % Cálculo do centróide
    s1 = 0;
    s2 = 0;
    for i = 500:6000 
        s1 = i*v(i) + s1;
        s2 = v(i) + s2;
    end
    
    valorConsumo = s1/s2;
    
    printf("O consumo esperado para %.2f °C e %.2f unidades monetárias é de aproximadamente:\n %.2f unidades.", temperatura, preco, valorConsumo);
   
else
    printf("\nDigite valores válidos!");
end

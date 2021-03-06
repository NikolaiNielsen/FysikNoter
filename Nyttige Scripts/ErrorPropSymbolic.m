clear all
clc

% For at f� dette script til at virke ordentligt skal f�lgende g�res:
% Skriv alle variable i formlen op efter "syms"
% Skriv alle variable op i "variables"
% Skriv alle v�rdier p� variablene op i "values"
% Skriv alle usikkerheder p� de variable op i "errors"
% Skriv formlen for st�rrelsen, hvis usikkerhed skal findes op i
% "expression"

% Det er vigtigt, at alle vektorer er af samme form - alts� alle skal enten
% v�re kommaseparerede eller mellemrumsseparerede. Hver variabel, og dennes
% tilh�rende v�rdi og usikkerhed skal st� i samme kolonne i hver sin vektor
% Eksempelvis er massen det f�rste element i "variables", massens v�rdi er
% f�rste element i "values" og usikkerheden p� massen er f�rste element i 
% "errors".

% som eksempel udregnes usikkerheden i den kinetiske energi, for et 2 kg
% objekt, der bev�ger sig med 10 m/s.

% Husk at alle v�rdier skal v�re i SI-enheder! Ellers risikerer du at du
% ikke f�r de rigtige enheder p� dit svar!

syms m v

variables = [m v];
values = [2 10];
errors = [0.001 0.1];

expression = 1/2*m*v^2;


for i = 1:length(variables)
	PartialDerivative(i) = diff(expression,variables(i));
	PartialValue(i) = subs(PartialDerivative(i),variables,values);
	Term(i) = PartialValue(i)*errors(i);
end

Error = sqrt( sum( Term.^2 ))
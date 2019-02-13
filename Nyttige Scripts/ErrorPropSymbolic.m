clear all
clc

% For at få dette script til at virke ordentligt skal følgende gøres:
% Skriv alle variable i formlen op efter "syms"
% Skriv alle variable op i "variables"
% Skriv alle værdier på variablene op i "values"
% Skriv alle usikkerheder på de variable op i "errors"
% Skriv formlen for størrelsen, hvis usikkerhed skal findes op i
% "expression"

% Det er vigtigt, at alle vektorer er af samme form - altså alle skal enten
% være kommaseparerede eller mellemrumsseparerede. Hver variabel, og dennes
% tilhørende værdi og usikkerhed skal stå i samme kolonne i hver sin vektor
% Eksempelvis er massen det første element i "variables", massens værdi er
% første element i "values" og usikkerheden på massen er første element i 
% "errors".

% som eksempel udregnes usikkerheden i den kinetiske energi, for et 2 kg
% objekt, der bevæger sig med 10 m/s.

% Husk at alle værdier skal være i SI-enheder! Ellers risikerer du at du
% ikke får de rigtige enheder på dit svar!

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
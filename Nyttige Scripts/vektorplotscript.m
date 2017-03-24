% Det obligatoriske
clear all
close all
clc



% Dette script har til formål at plotte diverse vektorfelter, strømlinjer,
% gradienter, curl, divergens og lignende.

% Variablene kan ændres i anden sektion (lige under denne kommentar), mens
% vektorfelterne (og/eller skalarfeltet) ændres i fjerde sektion 
% ("Her ændres vektorfelterne"). Der er også en stor fed kommentar ved det.

% Hvis en komponent i et vektorfelt er 0, så skriv "nul" ud for det (uden gåseøjne),
% det er en matrix af 0'er, i den rigtige størrelse. Alternativt kan der skrives
% x*0, der danner en matrix af rigtig størrelse, der kun har 0'er.

% Jeg synes selv kommentarene er letforståelige, men hvis der er nogen tvivl, så
% skriv endelig på facebook.

%% Her er de variable:
Dimensions = 2;		% antal dimensioner - 2 eller 3. Alt andet giver fejl
					% Lige nu kan den kun plotte ting i 2D - men den kan også lave
					% contourplots


xMin = -5;			% minimum for x
xInt = 0.5;			% Intervallet for x-værdier
xMax = 5;			% Maksimum for x

yMin = -1;
yInt = 0.2;
yMax = 3;

zMin = 1;
zInt = 1;
zMax = 1;

yEqualsx = 1;		% Hvis værdien er 1 sættes yMin=xMin etc. Ellers bruges
					% de andre værdier for yMin etc (dem du ændrer
					% herunder)
zEqualsx = 0;
					
faktor = 1;			% skaleringsfaktor til vektorer

vektorfelt = 0;		% antal vektorfelter der skal plottes i samme funktion.
kontur = 1;			% = 1 - plotter konturer
gradienten = 1;		% = 1 - plotter gradienten
farve = 0;			% = 1 - viser en colorbar
rotation = 0;		% udregner rotationen af 1 vektorfelt (kun 1 ad gangen)

polar = 0;			% = 1 - Bruger polære koordinater til visualiseringen.
					% skriv vektorfeltet i vr og vtheta i stedet for vx og vy.

Stroemlinjer = 1;	% = 1 - plotter strømlinjer
StartX{1} = 1;		% Startpunkt i x
StartY{1} = 1;		% Startpunkt i y
StartX{2} = 1;
StartY{2} = 1;


%% if-sætningen herunder sørger ændrer variabler efter yEqualsx=1
if yEqualsx == 1
	yMin=xMin;
	yMax=xMax;
	yInt = xInt;
end

if zEqualsx == 1
	zMin=xMin;
	zMax=xMax;
	zInt = xInt;
end

% Vi laver lige x- og y-koordinaterne
if Dimensions == 2
	[x,y]= meshgrid(xMin:xInt:xMax,yMin:yInt:yMax);
	[Lx,Ly] = size(x);
	r=sqrt(x.^2+y.^2);
	theta = acos(x./r);
	% Okay, det her er en rigtig grim workaround, for at få en pæn "spiral" fra 0 til
	% 2 pi for vinklen.
%  	theta(ceil(length(theta)/2) : length(theta),:) = 2*pi - theta(ceil(length(theta)/2) : length(theta),:);

	% Okay. Andet forsøg virkede.
	theta(1:floor(length(theta)/2),:) = 2*pi - theta(1:floor(length(theta)/2),:);
	nul = zeros(Lx,Ly);
elseif Dimensions == 3
	if zInt == 1 && zMin == 1 && zMax == 1
		[x,y,z]= meshgrid(xMin:xInt:xMax,yMin:yInt:yMax,1);
		r=sqrt(x.^2+y.^2);
	else
		[x,y,z]= meshgrid(xMin:xInt:xMax,yMin:yInt:yMax,zMin:zInt:zMax);
		r=sqrt(x.^2+y.^2+z.^2);
	end
else
	error('Dimensions skal være 2 eller 3!')
end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%								HER ÆNDRES VEKTORFELTERNE							%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vx{1} = 2*x.*y;
vy{1} = x.^2;

vy{2}=x;
vx{2}=y;

vz{1} = 0;
vz{2} = 0;

vr = -cos(theta)./(r.^2);
vtheta = -sin(theta)./(r.^2);

c = ['r','b','g','m','c'];	% Predefinerede farver: rød, blå, grøn, magenta og cyan. 
							% Den kører bare gennem denne liste, når der skal plottes
							% nye vektorfelter


beta = x.^2.*y;	% skalarfeltet


%% Selve scriptet starter her
if polar == 1
	vektorfelt = 1;
	vx{1} = cos(theta).*vr-sin(theta).*vtheta;
	vy{1} = sin(theta).*vr+cos(theta).*vtheta;
end 

if Dimensions == 2
	% Plotning af vektorfelt
	if vektorfelt > 0
		figure
		axis equal
		hold on
		for i = 1:vektorfelt
			quiver(x,y,vx{i},vy{i},faktor,'Color',c(i))
		end
		hold off
		if Stroemlinjer == 1
			hold on
			for i = 1:vektorfelt
				stroem{i}=streamslice(x,y,vx{i},vy{i});
				set(stroem{i},'Color',c(i))
			end
			hold off
		end
		if rotation == 1
			hold on
			[curlz,cav] = curl(x,y,vx{1},vy{1});
			[C,h] = contour(x,y,curlz,min(min(curlz)):1:max(max(curlz)));
			clabel(C, h,'fontname','Times','fontsize',20);
			hold off
		end
	end
	
	if kontur == 1 || gradienten == 1
		figure
		hold on
		axis equal
	end
	if kontur == 1
		contour(x,y,beta)
	end
	if gradienten == 1
		[dBx,dBy] = gradient(beta);
		quiver(x,y,dBx,dBy)
	end
	if farve == 1
		colorbar
	end
	hold off

end


% if Dimensions == 3
% 	
% 
% 	% Plotning af vektorfelt
% 	if vektorfelt > 0
% 		figure(fig)
% 		fig = fig+1;
% 		axis equal
% 		hold on
% 		for i = 1:vektorfelt
% 			quiver3(x,y,z,vx{i},vy{i},vz{i},faktor,'Color',c(i))
% 		end
% 		hold off
% 	end
% 	
% 	figure(fig)
% 	fig = fig+1;
% 	hold on
% 	% axis equal
% 	if kontur == 1
% 		contour(x,y,beta)
% 	end
% 	if gradienten == 1
% 		[dBx,dBy,dBz] = gradient(beta);
% 		quiver3(x,y,z,dBx,dBy,dBz)
% 	end
% 	if farve == 1
% 		colorbar
% 	end
% 	hold off
% 
% end
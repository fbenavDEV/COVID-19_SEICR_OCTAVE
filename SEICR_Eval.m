% Esta funci�n eval�a o resuelve la ecuaci�n diferencial asociada al modelo
% SEICR, como se describe en:
%
% https://www.medrxiv.org/content/10.1101/2020.05.19.20106492v1
%
% Se devuelve el vector soluci�n en pasos de una unidad, pero la ecuaci�n
% es resuelta usando el m�todo Runge-Kutta-Fehlberg, implementado dentro de los 
% algoritmos de Octave. La distribuci�n de los par�metros de la funci�n son:
%
% NP       poblaci�n total (por ejemplo, 2.5 millones) 
% t        vector creciente con los d�as evaluados
%          ibd vector con los valores:
%               ibd(1)  = I(0), N�mero de infectados iniciales
%               ibd(2)  = beta, Valor de beta o tasa de transimisi�n
%               ibd(3) = delta, Tasa de confinamiento 
% ep       Valor de epsilon o tasa de devoluci�n de la poblaci�n susceptible, una vez
%          que se han aliviado las medidas de confinamiento.
% ag       Vector con los valores de alpha, ag(1) y gamma, ag(2). El valor de alpha es 
%          la tasa de incubaci�n y el de gamma es la tasa de de eliminaci�n (cuando el 
%          paciente se ha recuperado). 
% idx      N�mero de columna que se retorna como resultado de la funci�n. Generalmente
%          es la columna n�mero 3 (n�mero de infectados) para optimizar con relaci�n 
%          a los datos activos de las tablas de COVID-19
% lock_fun Puntero a la funci�n de confinamiento (en relaci�n  a "t"). 

function retval = SEICR_Eval(NP,t,ibd,ep,ag,idx,lock_fun)  
  i = ibd(1);
  beta = ibd(2);
  delta = ibd(3);  
  eps = ep;
  alpha = ag(1);
  gamma = ag(2);
  prms = [beta alpha delta gamma eps];  
  mod = @(t,y) SEICR_Model(t,y,prms,lock_fun);  
  S = NP-i; 
  E = 0;
  I = i;  
  C = 0;
  R = 0;  
  in_cond = (1/NP)*[S E I C R]; 
  [tn,y] = ode45(mod,t,in_cond);
  y = NP*y;
  if (idx  == 0)
    retval = y;
  else
    retval = y(:,idx);
  end  
endfunction
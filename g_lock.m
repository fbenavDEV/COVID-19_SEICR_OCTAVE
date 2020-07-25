% Funci�n de confinamiento en el tiempo "t" con respecto a un vector de d�as
% lock_array que tiene 1 cuando no hay confinamiento y 0 cuando s� lo hay.
% Esto permite un ajuste fino de los d�a de confinamiento. 

function retval = g_lock (t,lock_array)
  t = round(t);
  if (t > length(lock_array))
    t = length(lock_array);
  end  
  retval = lock_array(t);
endfunction

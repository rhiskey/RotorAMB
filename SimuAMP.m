function SimuAMP
    a = sim('mTest','SimulationMode','normal');
    b = a.get('simout');
    assignin('base','b',b);
end
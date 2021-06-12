rewrite1(ID) :-
    namespace(FID,_),
    subject(FID,ID),
    format("ignore ~w~s", [FID]),
    format("namespace ~w~s", [FID]),
    

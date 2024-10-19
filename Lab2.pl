%Родинні звязки is_a (родо-видові)
is_a(car, vehicle).
is_a(bus, vehicle).
is_a(bike, vehicle).
is_a(plane,vechicle).
is_a(sedan, car).
is_a(suv, car).
is_a(sports_car, car).
is_a(mountain_bike, bike).
is_a(road_bike, bike).
is_a(minibus, bus).
is_a(double_decker, bus).
is_a(airplane, aircraft).
is_a(helicopter, aircraft).
is_a(airship, aircraft).

% Звязки частина-ціле part_of
part_of(engine, car).
part_of(wheel, car).
part_of(door, car).
part_of(gearbox, car).
part_of(seat, car).
part_of(bell, bike).
part_of(pedal, bike).
part_of(handlebar, bike).
part_of(roof, bus).
part_of(window, bus).
part_of(seat, bus).
part_of(wing, airplane).
part_of(engine, airplane).



% Заборона наслідування part_of через is_a
not_part_of_inheritance(X, Y) :- part_of(X, Y), is_a(X, Y), !, fail.
not_part_of_inheritance(_, _).

% Додаткові факти

% Асоціативний зв’язок - керує (drives)
drives(driver, vehicle).

% Залежність - для керування автомобілем потрібен водій
needs_driver(X) :- is_a(X, car), drives(driver, X).

% Правило для визначення чи є обєкт транспортним засобом
is_vehicle(X) :- is_a(X, vehicle).

% Правило для визначення, чи є X підтипом Y
subtype_of(X, Y) :- is_a(X, Y).
subtype_of(X, Y) :- is_a(X, Z), subtype_of(Z, Y).

% Правило для визначення, чи є X частиною Y
part_of(X, Y) :- part_of(X, Y).
part_of(X, Z) :- part_of(X, Y), part_of(Y, Z).

% Заборона просування part_of по is_a
can_inherit(X, Y) :- not_part_of_inheritance(X, Y).

% Правило для визначення наявності двигуна у транспортного засобу
has_engine(X) :- is_a(X, vehicle), (part_of(engine, X); has_engine(Y), is_a(X, Y)).

% Правило для визначення, чи має транспортний засіб педалі
has_pedals(X) :- is_a(X, bike); part_of(pedal, X).

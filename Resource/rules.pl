submit_rule(S) :-
	gerrit:default_submit(X),
	X =.. [submit | Ls],
	check_commit_message(Ls, R),
	S =.. [submit | R].
check_commit_message(S1, S2) :-
	valid_messages(),
	gerrit:commit_author(A),
	S2 = [label('Check-Commit', ok(A))|S1],
	!.
check_commit_message(S1, S2) :-
	CC = label('Check-Commit', reject(user(1000004))),
	S2 = [CC | S1].
valid_messages():-
    gerrit:commit_message_matches('^CR#QCCR\\d{1,2}[A-Z]\\d+: ').
valid_messages():-
    gerrit:commit_message_matches('^US#AGMRQ\\d{1,2}[A-Z]\\d+: ').
valid_messages():-
    gerrit:commit_message_matches('^US#OCTUS\\d{1,2}[A-Z]\\d+: ').
valid_messages():-
    gerrit:commit_message_matches('^US#OCTFT\\d{1,2}[A-Z]\\d+: ').
valid_messages():-
    gerrit:commit_message_matches('^CR#OCTCR\\d{1,2}[A-Z]\\d+: ').
valid_messages():-
    gerrit:commit_message_matches('^CR#OCTCL\\d{1,2}[A-Z]\\d+: ').
valid_messages():-
    gerrit:commit_message_matches('^Build: ').
valid_messages():-
    gerrit:commit_message_matches('^Revert "*').

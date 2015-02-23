#!/usr/bin/perl -w

##--   Ideas ideas
##--  
##--
##--  	* parse text files to get phrases/sentences then navigate thru these
##--  	* parse text files to get phrases/technical terms, that are then used
##--				within some defined grammar construct
##--  	* a gip command shell:
##--  			load text file
##--  			load a grammar file
##--  			move from one grammar to another
##--  			generate
##--  			etc.
##--  
##--		* move thru a text file, printing it in chunks of n lines at a time
##--				before/between each chunk, print some gen'd stuff, as if it's
##--				commentary or structural-annotation of the text.
##--  


##-- 
##-- #------------------------------------------------------
##-- Possible Generative Items & Ideas
##-- 
##-- ListOfQuotedWords
##-- ListOfQuotedPhrases
##-- ParameterEquals  (eg. mode = "discourse update" )
##-- VerbInfinitive  (eg. "to ask" )
##-- DiscourseConnective
##-- AffectList -- (INTENSE-FEAR, COSMIC-HARMONY, MYTHIC-REVELATORY) 
##--   (see abduction-time-assgn.txt
##-- MedicalStatusUpdate   (neuro-uptake, calibrate synpatic thresholds, etc.)
##--  MedicalDirective
##-- KeywordQuery ( high-priority keyword lookup attempt)
##-- Rorshach-likeMentalStateUpdate
##-- GeneralizedConstraint   eg. ensure <parameter-update>
##--  	* generator functions for 
##--			exceptions being reported
##--			journal citation
##--			architectural phrase
##--			list of technical terms from a selected domain  (eg. Apollo program)
##==
##==phrasal forms
##==	verb adj noun-phrase "create massive energy blockages"
##==	affect-noun preposition noun-phrase "reverence within the dense wavelengths"
##==	verb-imperative preposition noun-phrase  "focus into the escalation"
##==		??? "your function demands certain possibilities"
##==   ???  to-verb (in order to, as a consequence of, ...
##==   
##==Have different sets of various underlying selection arrays
##==(eg. verbs, nouns, cue phrases)
##==these are organized into named sets eg. AKBender, Expo2067, CrowleyInTheCrashGel
##==These named sets are connected to one another
##==selection/traversal logic is used to move thru/over these sets, as 
##==	a high-level discourse guiding regime.

##--  re: generative grammar notes
##--  
##--  1. epr - eval production rule
##--  	Should be able to write a production rule in some form eg.
##--  
##--  A ::= &A | &B &C | D | D e | E &f
##--  
##--  	and call a routine ("epr") on it to evaluate it:
##--  	::= indicates that A is a non-terminal
##--  	& indicates also a non-terminal
##--  	| distinguishes possible RHS productions
##--  
##--  	selection from the set of right-hand-sides can simply be made randomly.
##--  
##--  
##--  2. a generative grammar production algorithm would operate on a set of production rules,
##--  	iteratively scanning a working string that it is building, 
##--  	using some special delimiter (eg. '::|::' ) to indicate the various pieces that exist
##--  	in it at each step.
##--  
##--  	eg.
##--  	::|::A::|::&B::|::
##--  	
##--  	would be scanned and split into two pieces, A and &B
##--  	These are passed to evc() for evaluation, which recognizes the first as a string literal
##--  	(ie. a final terminal) and the second as a subroutine (ie. a non-terminal) which is then
##--  	eval'd.  Let's say &B returns 'bbb'... so next the string looks like
##--  
##--  
##--  	::|::A::|::bbb::|::
##--  	
##--  	the next iterative scan detects no non-terminals, so it can finish:
##--  
##--  	strip out the special delimiter, giving the final string
##--  
##--  	Abbb
##--  
##--  

#	
#	
#	
#	
#	
#	
#	

# FORWARD DECLS
#
#
sub pq;
sub infinitize;
sub inOrderToComplex;
sub ingize;
sub pluralizeVERB;
sub TranslatorComment;
sub genTranslatorComment;
sub PersonNumber;
sub PersonNumberTag;
sub random_ab;
sub pick_rand_elem;
sub Descriptor_random;
sub Descriptor_1sequence;
sub Descriptor_2sequence;
sub Descriptor_3sequence;
sub Descriptor_5sequence;
sub Descriptor_1sequence_nested;
sub Descriptor_3sequence_nested;
sub Descriptor_sequence;
sub ScopeTag;
sub ScopePlist;
sub ScopeDescriptor;
sub ScopeDescriptor_recursive;
sub ScopeDescriptorSequence_nested;
sub ScopeDescriptorSequence;
sub LexicalClarification;
sub Descriptor_prim;
sub Descriptor_comp;
sub genLexicalClarification;
sub evc;
sub ev_;
sub evalp;
sub longCuePhraseList_AKBender;
sub shortCuePhraseList;
sub ADJ_NOUN_phrase;
sub NOUN_NOUN_phrase;
sub selectDiscourseConnective;
sub linkage_operator;
sub build_pdf;
sub pick_unique_list;
sub pick_unique_listd;
sub disambiguate_until;
sub gen_nonTerminal;
sub gen_Terminal;
sub evalp1;
sub generateParameterName;
sub genParameterValue;
sub genParameterConditionOperator;
sub parameterUpdate;
sub statementLinkageSyntax; 
sub genPretty;
sub genPretty_test;
sub defineHierarchy;
sub biographicalQuery;
sub genInfinitiveVerbList;
sub genVerbalComplex;
#
#
# Arrays of things to select from
#
#

my @VERBs = ( 
'synchronize',
'update',
'focus',
'calibrate',
'synthesize',
'impress',
'interfere',
'transform',
'choose',
'deliver',
'block',
'localize',
'progress',
'accelerate',
'rejuvenate',
'seek',
'merge',
'arrange',
'sense',
'cause',
'transmit',
'focus',
'operate',
'create',
'limit',
'demand',
'overstate',
'multiplex',
'coalesce',
'project',
'refer',
'spread',
'enumerate',
'form'
);

my @Terminals = ( 
'&ADJ_NOUN_phrase',
'&ADJ_NOUN_phrase',
'&ADJ_NOUN_phrase',
'&shortCuePhraseList',
'&NOUN_NOUN_phrase',
'&genVerbalComplex', 
'&parameterUpdate',
'&parameterUpdate',
'&parameterUpdate'
);
my @NonTerminals = ( 
'informWhether',
'despiteEncodingOf',
'mapDomainSet',
'concedeEvidenceOf',
'emotiveAffect',
'local_designator',
'extendDiscreteTime',
'purposive_causative',
'findConnectiveRegime',
'personalKnowledgeQuery',
'successiveSamples',
'nucleateMotivation',
'&linkage_operator',
'&disambiguate_until',
'filterConcept',
'&selectDiscourseConnective',
'&defineHierarchy',
'&biographicalQuery',
'historicalKnowledgeAccess',
'sequencePresent',
'technicalQuery' 
);

my @GenericFunctionNames = (
'informWhether',
'knowWhether',
'summarize',
'contraryLimbicActivation',
'confirm',
'usingCriteria',
'crossReference',
'adoptPlan',
'updateCurrentGoal',
'refreshMapping',
'invertTransformation',
'despiteEncodingOf',
'mapDomainSet',
'concedeEvidenceOf',
'emotiveAffect',
'local_designator',
'extendDiscreteTime',
'purposive_causative',
'findConnectiveRegime',
'personalKnowledgeQuery',
'successiveSamples',
'nucleateMotivation',
'filterConcept',
'activateConcept',
'forgetConcept',
'expressedReference',
'accessMythicResonance',
'generateVariantsOf',
'historicalKnowledgeAccess',
'sequencePresent',
'technicalQuery' 
);

sub infinitize 
{
	my ($verb) = @_;
	my $s = "" ;
	$s .= 'to ' . $verb ;
	return $s ;
}


my @ParameterNames = ( 'discourse_Mode', 'reinsertion_timecode', 'intention_State' ) ;

#
#		discourse-connective complex
#
#

@DiscourseConnectives = (
'ADDITIVE-EMPHASIS',
'ALTERNATIVE',
'ANTI-SEQUENCE',
'ANTITHESIS',
'ANTITHESIS-SEQUENCE',
'ARGUMENTATION',
'BACKGROUND',
'BROKEN-INTENTION',
'CIRCUMSTANCE',
'COMPARISON',
'CONCESSION',
'CONCLUSION',
'CONCURRENCY',
'CONDITION',
'CONTINUATION',
'CONTRAST',
'COUNTER-EVIDENCE',
'DETAIL',
'DISAGGREGATION',
'DURATION',
'ELABORATION',
'ENABLEMENT',
'EVALUATION',
'EVIDENCE',
'EXAMPLE',
'EXPLANATION',
'FORWARD-REFERENCE',
'FINAL-STEP',
'INTERPRETATION',
'INTRODUCTION',
'JOINT',
'JUSTIFICATION',
'MEANS',
'MOTIVATION',
'NARRATION',
'NON-EVIDENCE',
'NON-EXPLANATION',
'NONVOLITIONAL-CAUSE',
'NONVOLITIONAL-RESULT',
'OR',
'OTHERWISE',
'OUTCOME',
'PARENTHETICAL',
'PROBLEM-SOLUTION',
'PURPOSE',
'QUESTION-ANSWER',
'REASON',
'REFUTATION',
'RESTATEMENT',
'SEQUENCE',
'SUMMARY',
'TOPIC-SHIFT',
'VOLITIONAL-CAUSE',
'VOLITIONAL-RESULT'
) ;


@SelectorConnectives = (
	'AT_MOST_ONE_OF',
	'LINK_WITH',
	'ANY_ONE_OF',
	'NONE_OF',
	'TWO_OF',
	'ALL_OF'
) ;

#@ChannelledPronouncement = ();
#    [1-4]-{sg|pl|indef}
#
#
@Person = ( 'sg', 'pl', 'indef' );
@Number = ( '1', '2', '3', '4' );


@LexicalClarifications = (
'spiralling; helical motion',
'acquiescent',
'fire; flame',
'water',
'of the number 4',
'(astral-liquid)',
'crystal; glass; light in motion',
'arbitrary; unrelated',
'winds; gases; other than the liquid or solid state'
);

@VerbalComplexAspects = (
'aerial-entelechic',
'aerial-locative',
'co-primal',
'dual-Agentive',
'complementizer',
'negentropic-ephemeral',
'thematic',
'discourse-focus',
'discourse-denial',
'liquid-orgasmic',
'calibrated-denial',
'neuro-uptake',
'influx-classifier',
'embed-limited',
'hidden-purposive',
'helio-mantic',
'macro-referential'
) ;



@Abbreviations = (
'*properName*',
'Adj',
'aerial-locative',
'co-primal',
'Agentive',
'aspect',
'compizer',
'thematic',
'Deictic',
'influx-agnt',
'influx-clsfier',
'NC',
'prep',
'RelProN',
'tense',
'Adj',
'Adv',
'Agt',
'Apro',
'Aux',
'Bpro',
'caus',
'Comp',
'Conj',
'Dioc',
'Dm',
'infx',
'Ipro',
'NC',
'Neg',
'Num',
'Part',
'perf',
'Prep',
'Pres',
'pst',
'psv',
'Relpro',
'rflx',
'RelN',
'Trm',
'V',
'PN'
);


##
## Translator Comments
##

#  These are comments or explanations of the
#		original signal and/or its analysis.
#
#  	<noun-phrase> <adj>
#  	<noun-phrase> <verb-past>
#		<feature>
#
#
@TranslatorComments = (
	'...',
	'??',
	'segmentation uncertain',
	'alternate gloss',
	'local ambiguity threshold approached',
	'entelechy focus uncertain',
	'lexico-entropic excessive',
	'signal degraded',
	'lexical-smoothing applied',
	'syntax averaging applied',
	'thematic scope uncertain',
	'imperative scope uncertain',
	'equational regime',
	'soritical complex suppressed',
	'focus-relative ambiguity',
	'co-focus ambiguity',
	'presumed co-relative',
	'unrecognized rhetorical construct',
	'unrecognized imperative construct',
	'unrecognized discourse sub-mode',
	'bi-cubic interpolation',
	'signal region singularity'
);


##	expr_list ::= (expr)+
##	expr ::= (expr) | prim
##	prim ::= <some-prim-stuff>

sub prim {
	# "P";
	&Descriptor_3sequence ;
}

sub expr {
	my $res;

	if ( rand() < 0.6 ) {
			$res .= &prim ;
	}
	else {
		$res = "(". &expr . "-" . &expr . ")";
	}
	
	$res;
}

sub expr_list {
	my ($res);
	for (0..2) {
		$res .= &expr . "  ";
	}
	$res;
}

$MorphemeBoundary = "(.)";


# grammar for Translator Comment
#-- 
#-- <proviso> <rhetorical-feature>
#-- <proviso> ::= {unrecognized | uncertain | suggested | predicted} 
#-- <rhetorical-feature> ::= 'thematic scope', 'co-relative plural', 'entelechy focus' ...
#-- 
#-- 
#-- Adj AnalyticOperation Verb 
#-- Adj <rhetorical-feature> Verb 
#-- Verb ::= { applied | suppressed | enhanced | deferred }
#-- AnalyticOperation ::= 
#-- 
#-- Adj <signal-feature> | Adj <rhetorical-feature>
#-- <signal-feature> ::= { ambiguity | memetic entropy | ... }
#-- 
#-- Adj ::= excessive, ...
#-- 
#-- 

sub TranslatorComment {
	my( $s );
	$s = &pick_rand_elem( @TranslatorComments ) ;
	##NBprint ("TranslatorComment: returning: $s\n");
	return "[=" . $s . "=]";
}

sub genTranslatorComment {
    if (rand() < 0.3) {
			return " ". TranslatorComment() ; 
    }
		else { 
			return "" ;
		}
}



#-- # pattern for generation of array-selected items
#-- 
#-- @A - the Array of items from which selections are made
#-- sub AS - routine to select an item from @A
#-- 	- done randomly or by some other means
#-- sub genAS - routine to (random-selectively) generate an AS string, with added delimiters
#-- 	- a determination is made whether or not to generate anything eg. random number selection
#-- 	- delimiters are added, if desired
#-- 
#-- 
#--------- how to define generic routines for this?
#--  see "closures" in perl,
#-- 	http://www.perldoc.com/perl5.6/pod/perlref.html
#-- 



sub PersonNumber {
	&pick_rand_elem( @Number ) . "-" . &pick_rand_elem( @Person );
}

sub PersonNumberTag {
		my $res .= "-(" . &PersonNumber . ")";
}




# pick random integer between given A and B
#
#
sub random_ab {
	my ($a,$b) = @_;
	return int(rand($b-$a)) + $a ;
}

# pick i, rand number between 0-th and n-th item in array "Abbreviations"
#  $#the_array -- last index of array the_array
#  conditionally 'eval' the selected item.
#
sub pick_rand_elem {
	my( @the_array ) = @_;
	&evc( $the_array[int(rand($#the_array +1))] );
}


sub Descriptor_random {
		&pick_rand_elem( @Abbreviations );
}

sub Descriptor_1sequence {
		&Descriptor_random;
}
sub Descriptor_2sequence {
		&Descriptor_sequence(2);
}
sub Descriptor_3sequence {
		&Descriptor_sequence(3);
}
sub Descriptor_5sequence {
		&Descriptor_sequence(5);
}

sub Descriptor_1sequence_nested {
	my ($res);
	for( 0..1 ) {
		$res .= (rand() < 0.3) ? &Descriptor_2sequence : &ScopeDescriptorSequence_nested; 
	}
	$res;
}


sub Descriptor_3sequence_nested {
	my ($res);
	for( 0..4 ) {
		$res .= (rand() < 0.3) ? &Descriptor_random : &ScopeDescriptorSequence_nested; 
	}
	$res;
}

sub Descriptor_sequence {
	my ($i) = @_ ;		# random number; gen up to this many items, hyphen-sep'd
	my ($j, $sld);

	 ##NBprint "Descriptor_sequence: input i = $i\n";

	for ( $sld = "", $j=0; $j < $i; $j++) {
		$sld .= &Descriptor_random ;
		$sld .= ( $j < ($i -1) ) ? "-" : "" ;
	} 
	$sld ;	
}

#   <scope-begin> 						::= "["
#   <scope-end> 							::= "]"
#		<scope-plist-begin>	::= "{"
#		<scope-plist-end>		::= "}"
#

$ScopeBegin 			= "[" ;
$ScopeEnd 				= "]" ;
$ScopePlistBegin 	= "{" ;
$ScopePlistEnd 		= "}" ;

sub ScopeTag {
	&Descriptor_3sequence ;
}

# ScopePlist ::= <descriptor-3sequence> [ PersonNumberTag ]
#
#
sub ScopePlist {
	my $res ;
	$res .= &Descriptor_3sequence ;


	if (rand() < 0.1) {
		$res .= "--" . &PersonNumber;
	}

	$res;
}
	

# ie.
#  ScopeDescriptor ::= [ <ScopeTag>{ <ScopePlist> } ]
#
#
sub ScopeDescriptor {
	my $res ;

	$res .= $ScopeBegin ;
	$res .= &ScopeTag ;

	$res .= $ScopePlistBegin;
	$res .= &ScopePlist;
	$res .= $ScopePlistEnd;

	$res .= $ScopeEnd ;
	$res ;
}

#
# ScopeDescriptor_recursive ::= 
#			ScopeBegin { ScopeTag | ScopeDescriptor_recursive } ScopeEnd
#
sub ScopeDescriptor_recursive {
	my $res ;

	$res .= "[";

	if ( rand() < 0.3 ) {
		$res .= &ScopeDescriptor_recursive ;
	} else {
		$res .= &ScopeTag ;
	}
	$res .= "]" ;

	$res ;
}

#
#	ScopeDescriptorSequence_nested ::= ScopeDescriptor_recursive{1,4}
#
sub ScopeDescriptorSequence_nested {
	my ($res, $i, $dcount);
	$dcount = &random_ab(1,4);

	for( $i=0; $i < $dcount; $i++ ) {
		$res .= &ScopeDescriptor_recursive ;
	}
	$res;
}

sub ScopeDescriptorSequence {
	my ($res, $i, $dcount);
	$dcount = &random_ab(1,3);
	for( $i=0; $i < $dcount; $i++ ) {
		$res .= &ScopeDescriptor . ( $i == $dcount-1 ? "" : $MorphemeBoundary );
	}
	return $res;
}



sub LexicalClarification {
	my( $s );
	$s = &pick_rand_elem( @LexicalClarifications ) ;
	##NBprint ("LexicalClarification: returning: $s\n");
	return "{" . $s . "}" ;
}

#  primitive Descriptor
#
sub Descriptor_prim {
	&pick_rand_elem( @Abbreviations ) ;
}

#  composite Descriptor
#
sub Descriptor_comp {
	;
}


#
#
#
#
#
sub genLexicalClarification {
	return (rand() < 0.3) ? ( " ". LexicalClarification() ) : "" ;
}



sub inputline_is_empty_text{
	my ($s) = @_ ;		
	return ( length($s) <= 1 );
}




#
#
#  main text interpolation routine
#
#
sub file_interpolate {
	my( $ddd );

	while (<>) {
		print "$_" ;

		next if ( inputline_is_empty_text($_) ) ;

		##==if ( !inputline_is_empty_text($_) ){

			# print parse-specification
			# $ddd = &ScopeDescriptorSequence ;
			print "( " . &ScopeDescriptorSequence ." )\n" ;

			print genLexicalClarification() ;
	
			# print translation commentary (possibly)
			print genTranslatorComment() ;
	
			print "\n" x 2;
		##==}


	}
}



# eval conditionally -- using leading '&'
#
sub evc {
	my ( $ee ) = @_ ;
	my ( $e2 ) = $ee ;
	my $patt = '^&' ;
	my $rr = ($e2 =~ m/$patt/) ;
	my $ss = "";

		#print "evc: patt: $patt  vs. $ee  -- rr: $rr" ;

	$ss = $ee ;
	if ( $rr )
	{
		#print "-- \t\tmatch\n" ;
		$ss = eval($ee) ;
	}
	else 
	{
		#print "-- \t\tno match\n" ;
	}

	# ($ee =~ m/$patt/) ? eval($ee) : $ee ;
	#print ( "evc: return: $ss\n" );
	$ss ;
}

sub f1 {
	"f1 called" ;
}
sub f2 {
	"f2 called" ;
}

sub TEST_evc {
	my $ss ;
	evc( "a" );
	evc( '&a' );
	evc( "bbb" );
	evc( "&f1" );
	evc( "b2b" );
	evc( "&f2" );
	evc( "&1+5" );
}



# eval probabilistically an item from a list
#   inputs:   
#				pdf_ref  : array of reals defining a probability distribution function
#												(each i in pdf_ref < 1, and the sum of the i's is 1.0)
#				eval_ref : array of items to be selected from and eval'd
#												(the  number of items in eval_ref is the same as in pdf_ref)
#
sub evalp {
	my ( $pdf_ref, $eval_ref ) = @_ ;

##==	print ( "evalp: \n" );
##==	print ( "aref: @{$pdf_ref}\n" );
##==	print ( "bref: @{$eval_ref}\n" );
##==	foreach $item ( @{$eval_ref} )
##==	{
##==		print ( "-----item: $item \n" );
##==		print ( "-----eval: " . eval($item) . "\n" );
##==		#eval( $item ) ;
##==	}

	
	my ( $x ) = rand() ;  # pick x in interval (0, 1)

##==	 print ( "pdf_ref : @{$pdf_ref}\n" );
##==	 print ( "eval_ref: @{$eval_ref}\n" );
##==	 print ( "x       : $x\n" );

	my ( $sum ) = 0.0;
	my ( $ii ) = 0 ;
	foreach $p_item ( @{$pdf_ref} ) 
	{
		$sum += $p_item ;
		last if ( $x <= $sum ) ;
		$ii++ ;
	}
##==	print ( "selected i = $ii ---- eval_ref: $eval_ref->[$ii]\n" );

	#return eval ( '$eval_ref->[$ii]' ) ;
	return eval ( $eval_ref->[$ii] ) ;

}


sub test_evalp {
	my @aa_pdf = ( .1, .2, .25, .3, .15 ) ;
	my @aa_val = ( 'a', 'b', 'c', 'd', 'e' ) ;

	for ( 1..1000 )
	{
		evalp( \@aa_pdf, \@aa_val );
	}
}

sub sub1 {
	return "return from sub1" ;
}


sub test_eval {

my @BB = ( 'sub1', '&sub1', 'eval &sub1', '\&sub1' );
# "sub1", "&sub1", "eval &sub1", "\&sub1" );

my $e1;
for my $elem (@BB) {
	print ("--------------\n");
	#$e1 = eval ( '$elem' ) ;
	$e1 = eval ( $elem ) ;
	#$e2 = eval ( $e1 ) ;
	print ( "$elem " );
	print ( " -- eval( elem ): " . $e1 );
	#print ( " -- eval2( elem ): " . $e2  );
	print ( "\n" );
}


}

# ---------------------------------------------------------

$gen_Max_Rec_Depth = 5;
$gen_Arg_Span = 4 ;
#$gen_MultiLine = 0 ;


	my @ADJs = 
(
'verbal',
'inflectional',
'dethematization',
'inchoative',
'cislocative',
'characteristic',
'transitive',
'oneiric',
'fabulized',
'proprioceptive',
'functional',
'contextual',
'reconfigured',
'libidinal',
'orgasmic',
'sequential',
'explanatory',
'post-nominal',
'situational',
);

	my @NOUNs = 
(
'predicate',
'formation',
'morphology',
'complex',
'tone pattern',
'feature',
'numeration',
'projection',
'dethematization',
'topic',
'node',
'domain',
'spread',
'reference',
'construction',
'projection',
'relevance',
'task',
'style',
'projection',
'honorific',
);


## automated-reasoning NOUNS
my @NOUNs_auto_reason =
(
);

my @ShortCuePhrases = (
'"choice of abundance"',
'"see everything within the possibilities"',
'"remote sensing of choice and experience"',
'"spectral selectivity"',
'"operate freely"',
'"create massive energy blockages"',
'"focus into the escalation"',
'"the limitations of the skip area"',
'"transmitting life itself"',
'"reverence within the dense wavelengths"',
'"causing a connection"',
'"in the larval stages"',
'"a multiplexing whole"',
'"overstate the dangers"',
'"coalescing its resonance"',
'"weaponry is a tunable source"',
'"your function demands certain possibilities"',
'"new directives"'
);

my @CuePhrases = (
'"causing a connection within the complex topologies"',
'"achieving a resonance with the strong fields of the F region"',
'"focus into the time of choice and experience"',
'"the escalation of weaponry will create massive energy blockages"',
'"we cannot overstate the dangers"',
'"usually a tunable origination point will emerge from the parasitic topologies"',
'"already your eyes are completely open"',
'"allow remote sensing of the skip area "',
'"the projection of your reverence"',
'"prepare to receive new directives "',
'"to function as a multiplexing whole"',
'"in the choice of experience"',
'"your human abundance is a tunable source"',
'"reverence for the projection of your light-possibilities"',
'"hold you fixed within the dense wavelengths"',
'"these twelve vortex variants coalesce into a tunable source"',
'"your freedom will demand certain possibilities"',
'"operate freely in the third optical window"',
'"a new kind of human freedom"',
'"inside the limitation of the narrow channel"',
'"in the larval stages of coalescing its light-possibilities"',
'"moving to see everything all at once"',
'"transmitting life itself "',
'"a device of almost cosmic power"',
'"sensing other signals"',
'"causing your human life waves to synchronize "',
'"within a resonant perception of new directives"',
'"simply because we can see everything all at once"',
'"transforming your place within the rejuvenated possibilities"',
'"arduous awareness of dimensional patterning "',
'"the initial stages of spectral selectivity"',
'"regardless of the parasitic signals coming from the neighbor channels"',
'"a device to allow you to move ever forward"',
'"impressing their messages onto precisely arranged streams of energetic particles"',
'"localized disturbances in the auroral zone "',
'"temporarily synchronize with human brain waves"',
'"power-hungry attitudes limit your rejuvenated light pulses"',
'"the old spiral of already delivered messages "',
'"operate in the initial stages of the invaluable sea"',
'"variants within the fiber itself could limit the powers of your world "',
'"lengthy moments of blending and stepped up modulation"',
'"massive perception blockages focus the localized disturbances"',
'"networking is progressing in new moments of accelerated awareness"',
'"the path we seek will emerge from the sea at 96 points"',
'"a merging of the two worlds"',
'"all human things are leveled in vast chaos"'
);

my @CuePhrases_AKBender = (
"overall grandiloquence of extravagance",
"the endless parade of priceless and superhuman novelties",
"flooded with an iridescent flow of thought-force",
"a musky supersensuous odour of indescribable allure",
"you will construct its successor device",
"slowly, suffusing into the room",
"excitation, basal arousal, capillary cavernosa",
"every extravagant swelling, secret curve, opulent bulge, and inviting dimple",
"the soft, libidinal aspects of intimacy",
"the fluidity of defensive operations and their failure",
"as they undulated in this double-height transparent space",
"the visible manifestation of some other, hidden topology",
"dangerous states of disorientation upon exposure to the space environment",
"below the extravagant swelling",
"flooded with a cumulative rapture",
"undulated across the night",
"to establish friendly relations with its successor device",
"below the injury threshold in the neuronal system",
"it will make life better for you",
"slipping from my conscious control",
"to land on earth with a friendly gesture",
"to establish friendly relations with the flying saucer people",
"eliciting some cumulative rapture",
"persistences of afterimages and occurrences of scotoma",
"a lower threshold for photophobia",
"thirteen distinct electrode sites",
"they undulated and rubbed themselves against me",
"operating the neuro-musculature of their faces",
"the full unfolding of consequences",
"night swimming with stars",
"slowly disintegrating into a pitiful dross",
"a coded gesture over a crystalline activation node",
"serene arrangements of singular splendour",
"a sweet, pleasant beneficial force, iridescent",
"quivering fields of electric potential across their cerebro-thalamic cortices",
"greatly enhanced contact with their bodies",
"the coalescing feeling of the crystalline activation potential",
"rapid accumulation of afterimages",
"remembering nothing of the coalescing feeling",
"remembering nothing of the elegant ancestors",
"vague embarrassment as they undulated themselves against me",
"the world-wide broadcasting of harmonizing, concordant impulses",
"a long line of sensitive ancestors who were fully aware",
"certain precise neural mechanisms",
"the mind operating on a constant reception-stream ",
"vague embarrassment as I undressed",
"massaged the liquid into my skin",
"since our first descent into matter",
"dilating glottis-like",
"this exhilarating feeling of remarkable events about to unfold",
"tracing sinuous curves of the utmost vermiculate intricacy across my flesh",
"the soft pads of their elegant fingers, stroking",
"despite his continuing paralysis",
"lacking in any overt defensive manoeuvres",
"filling his perceptual spaces with external excitation",
"rapid accumulation of additional mutations",
"the coalescing infinitude of the universe",
"remembering nothing of my normal life",
"beyond its surface architecture, as if through a collapsible set of realities",
"melting, undulating, expanding, contracting",
"delicate possibilities of the utmost vermiculate intricacy",
"tracing minute gravitic vortices across their cerebro-thalamic cortices",
"despite a sweet, pleasant beneficial force",
"delicate floating films of color",
"an agenda of metamorphosis and change",
"the ongoing redefinition of space",
"the possibility of some new kind of gravity",
"emancipatory potential of continually appearing forms",
"playful hierarchies of open space",
"throbbed with the reeking transformation",
"the whole bioplasmic intake of the entity",
"minute gravitic vortices",
"vocalizations and more or less intelligible speech",
"in the precentral gyros and the supplementary motor area",
"phrased with arrangements of splendour",
"squirming in the searing effulgence",
"crackled from the tips of their serpentine fingers",
"the cause of the bitter and turbulent anguish ",
"retreated into the shadows",
"millions of metric tons of ocean water"
);


sub longCuePhraseList_AKBender {
	my $s = "";
	$s .= &pick_unique_list( &random_ab(1, 3), \@CuePhrases_AKBender ); 
	return $s ;
}
sub shortCuePhraseList {
	my $s = "";
	$s .= &pick_unique_list( &random_ab(1, 4), \@ShortCuePhrases ); 
	return $s ;
}

sub ADJ_NOUN_phrase {
	my $s = "";
	$s .= '"' . &pick_rand_elem( @ADJs ) . "-" . &pick_rand_elem( @NOUNs ) . '"' ;
	return $s ;
}


sub NOUN_NOUN_phrase {
	my $s = "";
	my $s1 = "";
	my $s2 = "";
	
	$s .= '"' ;
	$s1 .= &pick_rand_elem( @NOUNs ) ;
	$s .= $s1 ;
	$s .= "-" ;

	while ( 1 )
	{
		$s2 = &pick_rand_elem( @NOUNs ) ;
		last if $s1 ne $s2 ;
	}
	$s .= $s2 ;
	$s .= '"' ;
	return $s ;
}
sub selectDiscourseConnective {
	my $s = "";
	$s .= &pick_rand_elem( @DiscourseConnectives ) ;
	if ( rand() < 0.4 ) {
		$s .= "-" ;
		$s .= &pick_rand_elem( @DiscourseConnectives ) ;
	}
	return $s ;
}



sub linkage_operator {
	&pick_rand_elem( @SelectorConnectives ) ;
}


my @AA = ( ".2", ".2", ".2", ".2", ".2" );
my @BB = ( 'aa', 'bb', 'cc', 'dd', 'ee' );

my @CC = ( 
'informWhether',
'despiteEncodingOf',
'mapDomainSet',
'&ADJ_NOUN_phrase',
'&NOUN_NOUN_phrase',
'&selectDiscourseConnective',
'&parameterUpdate',
'concedeEvidenceOf',
'emotiveAffect',
'disambiguate_until',
'&longCuePhraseList_AKBender',
'filterConcept',
'defineHierarchy',
'sequencePresent',
'technicalQuery' 
);

my @CC_pdf = &build_pdf( \@CC ) ;

my @CC_pdf1 = (
'0.05',
'0.15',
'0.15',
'0.1',
'0.1',
'0.1',
'0.1',
'0.05',
'0.1',
'0.1'
);

sub build_pdf {
	my ( $eval_ref ) = @_ ;
	my @ary ;	
	my $numArrayElems = $#{$eval_ref} ;
	my $p = 1.0 / $numArrayElems ;
	for ( 0 .. $numArrayElems )
	{
		push @ary, $p ;
	}
	return @ary ;
}
sub test_build_pdf {
	my @aa = ( 1, 2, 3, 4 ) ;
	my @bb = &build_pdf( \@aa ) ;
	print ( "aa: @aa\n" );
	print ( "bb: @bb\n" );
}



sub pick_unique_list
{
	my ( $num_elems, $elems_ref ) = @_ ;
	return &pick_unique_listd( $num_elems, $elems_ref, ', ' ) ;
} 

sub pick_unique_listd 
{
	my ( $num_elems, $elems_ref, $delim ) = @_ ;
	my $s = "";

##==print( "pick_unique_list: elems_ref: @{$elems_ref} \n" );
##==print( "pick_unique_list: num_elems: $num_elems\n" );
##==print( "pick_unique_list: #        : $#{$elems_ref}\n" );
	# bail, if there aren't enough items in the list to pick from
	return $s if ( $num_elems > $#{$elems_ref} ) ;

	# construct a list of picked elements
	my @picked_elems ;

	for ( 1..$num_elems )
	{
##==print( "pick_unique_list: loop... \n" );
		my $new_elem ;
		while (1) 
		{
			$new_elem = &pick_rand_elem( @{$elems_ref} ) ;
##==print( "pick_unique_list: new_elem: $new_elem \n" );
			last if ( ! grep( /$new_elem/, @picked_elems ) ) ;
		}
		push( @picked_elems, $new_elem ); 
	}

##==print( "pick_unique_list: final picked: @picked_elems \n" );
	# convert the list to a string
	join ( $delim, @picked_elems );
}




sub TEST_pick_unique_list 
{
	my @aa = ( 'a', 'b','c','d','e','f','g' );

	print ( "aa = @aa\n" );
		my $g ;
		my $a='a';
		my $x='x';
		$g = grep( /$x/, @aa ) ;
		print( "item: x  -- g: $g \n" );
		$g = grep( /$a/, @aa ) ;
		print( "item: a  -- g: $g \n" );
	

	
	my @p3 = &pick_unique_list(3, \@aa ); 
	my @p5 = &pick_unique_list(5, \@aa ); 

	print ( "uniq list 3: @p3\n" );
	print ( "uniq list 5: @p5\n" );

}

sub disambiguate_until {
	my $ss = "";

	$ss .= "disambiguate_until: " . &linkage_operator . '( ' . &parameterUpdate . " )" ;
	return $ss ;
}



sub evalp1 {
	&evalp( \@CC_pdf, \@CC ) ;
}


sub generateParameterName {
	my $s = "";
	my $delim = '_' ;
	$s .= &pick_rand_elem( @ADJs ) ;
	$s .= $delim . &pick_unique_listd( 2, \@NOUNs, $delim ) ; 
	$s ;
}

sub genParameterValue {
	my $s = "";
	if ( rand() < 0.5 ) {
		$s .= '"' . &pick_rand_elem( @VERBs ) . '"' ;
	} else {
		$s .= &pick_unique_list( 1, \@ShortCuePhrases) ;
	}
	return $s ;
}

sub genParameterConditionOperator {
	my @ops = ( 'equals', 'disjoint_from', 'not_like', 'similar_to' ) ;
	return &pick_rand_elem( @ops ) ;
}


sub parameterUpdate {
	my $s = "";
	if ( rand() < 0.4 ) {
		$s .= &pick_rand_elem( @ParameterNames ) ;
	} else {
		$s .= &generateParameterName ;
	}
	$s = uc( $s ) ;
	$s .= ' ' . &genParameterConditionOperator . ' ' ;
	$s .= &genParameterValue ;
	return $s ;
}

sub getVERB { &pick_rand_elem( @VERBs ) ; }
sub getADJ { &pick_rand_elem( @ADJs ) ; }
sub getNOUN { &pick_rand_elem( @NOUNs ) ; }
sub getpluralNOUN { &pluralize( &pick_rand_elem( @NOUNs ) ); }

sub genPretty1 
{
	#  rec_depth :: current recursive depth

	my ( $arg_span, $rec_depth ) = @_ ;

	my ($gen_ss) = "" ;

	$rec_depth++ ;

	# $gen_ss .= pick an item 
	$gen_ss .= &evalp1 ;

#print ( "  " x $rec_depth . "picked item at depth: $rec_depth -- $gen_ss\n" );

	my $local_Max_Rec_Depth = &random_ab(3, $gen_Max_Rec_Depth) ;
	if ( $rec_depth >= $local_Max_Rec_Depth ) 
	{ 
#print ( "  " x $rec_depth . "exit genPretty at depth: $rec_depth -- $gen_ss\n" );
		return $gen_ss ; 
	}

		# pick a number , args, in [1..arg_span]
		my $argn = &random_ab(1, $arg_span) ;
		my $parens = ( $argn > 0 ) ;
		
	$gen_ss .= ( $parens ? "( " : "" ) ;
	
		my $add_ss = "" ;
		for ( my $i = 1 ; $i <= $argn; $i++ )
		{
			$add_ss = "" ;
			$add_ss .= &genPretty1( $arg_span, $rec_depth ) ;
			$gen_ss .= $add_ss ;
			$gen_ss .= (($i < $argn) && ( $add_ss ne "" )) ? ", " : " " ; 
		}
	$gen_ss .= ( $parens ? ")" : "" ) ;
	return $gen_ss ;

}


sub genPretty2 
{
	#  rec_depth :: current recursive depth

	my ( $arg_span, $rec_depth, $evalp_ref ) = @_ ;
	my ($gen_ss) = "" ;

	$rec_depth++ ;

	# pick an item 
	$gen_ss .= &$evalp_ref ;

	my $local_Max_Rec_Depth = &random_ab(3, $gen_Max_Rec_Depth) ;
	if ( $rec_depth >= $local_Max_Rec_Depth ) 
	{ 
		return $gen_ss ; 
	}

	# pick a number , args, in [1..arg_span]
	my $argn = &random_ab(1, $arg_span) ;
	my $parens = ( $argn > 0 ) ;
		
	$gen_ss .= ( $parens ? "( " : "" ) ;
	
		my $add_ss = "" ;
		for ( my $i = 1 ; $i <= $argn; $i++ )
		{
			$add_ss = "" ;
			$add_ss .= &genPretty2( $arg_span, $rec_depth, $evalp_ref ) ;
			$gen_ss .= $add_ss ;
			$gen_ss .= (($i < $argn) && ( $add_ss ne "" )) ? ", " : " " ; 
		}
	$gen_ss .= ( $parens ? ")" : "" ) ;
	return $gen_ss ;

}

my @statementLinkageSyntaxMarkers = (
';',
':',
'==>',
'-@@',
'|'
);

sub statementLinkageSyntax 
{
	&pick_rand_elem( @statementLinkageSyntaxMarkers ) ;
}


sub inOrderToComplex {
	my $s ;
	my $v = &pick_rand_elem(@VERBs) ;
	if ( rand() < 0.2)
	{
		$s .= &pluralizeVERB(&pick_rand_elem(@VERBs)) . " [in order to] " ;
		$s .= $v ; 
	} else {
		$s .= &infinitize($v) ; 
	}
}


sub defineHierarchy {
	my $s = "";
	my @hierarchUsing = ( 'using','allowing','requiring','avoiding','subsuming' );

	$s .= 'defineHierarchy' ;
	$s .= '(' ;
	$s .= &pick_rand_elem( @hierarchUsing ) . ': ' ;
	if ( rand() < 0.6 ) {
	$s .= &pick_unique_list( 3, \@Terminals ) ; 
	} else {
	$s .= &pq(&inOrderToComplex) ;
	}
	$s .= ')' ;

	return $s ;
}

sub biographicalQuery {
	my $s = "";
	$s .= 'biographicalQuery' ;
	$s .= '(' ;
	$s .= &inOrderToComplex;
	$s .= ": " ;
	$s .= &pick_rand_elem( @CuePhrases ) ;
	$s .= ')' ;
#print ( "biographicalQuery: $s\n");
	return $s ;
}

sub genInfinitiveVerbList 
{
	my $s = "";
	my ($verblist) = &pick_unique_list( &random_ab(2, 4), \@VERBs); 
	my @newverblist = map ( &infinitize($_), split ( ', ' , $verblist ) );
	$s = join( ', ', @newverblist );

	return $s ;
}

sub genVerbalComplex {
	my $s = "";

	$s .= 'verbalComplex{ ' . '(' . &ScopePlist . ')'  ;
	$s .= ( rand() < 0.5 ) ? "" : '(' . &pick_unique_list( &random_ab(1, 2), \@VerbalComplexAspects ) . ')' ;
	$s .= ': ' ;
	$s .= &genInfinitiveVerbList ;
	$s .= '}' ;

	return $s ;
}

sub VerbalComplexAspect {
	&pick_rand_elem( @VerbalComplexAspects ) ;
}


##
## further linguistics verbiage:
##
##
# 
# predicate formation 
# verbal morphology 
# complex of suffixes 
# inflectional tone pattern
# feature numeration
# verbal projections
# VP-shell
# dethematization
# inchoative
# cislocative
# topic construction
# characteristic node
# domain of spread
#  pronominal reference
#  transitive construction
#  functional projection
# contextual relevance
# sequence task
#  explanatory style
# post-nominal projection
# solidarity honorific
# situational
# 

my @NonTerminals_pdf = &build_pdf( \@NonTerminals ) ;
my @Terminals_pdf = &build_pdf( \@Terminals ) ;
sub gen_nonTerminal {
	&evalp( \@NonTerminals_pdf, \@NonTerminals ) ;
}
sub gen_Terminal {
	&evalp( \@Terminals_pdf, \@Terminals ) ;
}


##==
##==

sub genPretty 
{
	my ( $arg_span, $rec_depth, $nonterminals_ref, $terminals_ref ) = @_ ;
	#  rec_depth :: current recursive depth
	# $nonterminals_ref : a ref to a subroutine which will generate a non-Terminal
	# $terminals_ref : a ref to a subroutine which will generate a Terminal


	my ($gen_ss) = "" ;

	$rec_depth++ ;


	my $local_Max_Rec_Depth = &random_ab(3, $gen_Max_Rec_Depth) ;
	if ( $rec_depth >= $local_Max_Rec_Depth ) 
	{ 
		# at the depth for Terminals; pick one of them
		$gen_ss .= &$terminals_ref ;
		return $gen_ss ; 
	}

	# otherwise, we're still at non-Terminal depth; pick one of them
	$gen_ss .= &$nonterminals_ref ;

	# pick a number , args, in [1..arg_span]
	my $argn = &random_ab(1, $arg_span) ;
		
	$gen_ss .= "( " ;
	
		my $add_ss = "" ;
		for ( my $i = 1 ; $i <= $argn; $i++ )
		{
			$add_ss = "" ;
			$add_ss .= &genPretty( $arg_span, $rec_depth, $nonterminals_ref, $terminals_ref) ;
			$gen_ss .= $add_ss ;
			$gen_ss .= (($i < $argn) && ( $add_ss ne "" )) ? ", " : " " ; 
		}
	$gen_ss .= ")" ;
	return $gen_ss ;

}


sub genPretty_test {

	my $ss = "";

	for ( 1..30 )
	{
		$gen_Max_Rec_Depth = &random_ab(3, 11) ;
		$gen_Arg_Span = &random_ab(2, 6) ;

		$ss = "" ;

		$ss .= &genPretty( $gen_Arg_Span, 1, \&gen_nonTerminal, \&gen_Terminal ) ;

		print ( "==> $ss\n" );
	}
}

sub pq { my ($w) = @_ ; return '"' . $w . '"' ; }


sub pluralize 
{ 
	my ($noun) = @_ ; 
	my $patt_sx = '[sx]$' ;
	my $patt_y = '[y]$' ;

	
	if ($noun =~ m/$patt_sx/) { return $noun . "es" ; }

	if ($noun =~ m/$patt_y/) 
	{ 
		return substr($noun, 0, -1) . "ies" ;
	}

	return $noun . "s" ;
}

sub pluralizeVERB { my ($verb) = @_ ; return &pluralize($verb) ; }

sub ingize 
{
	my ($verb) = @_ ;
	my $s = "";
	$s .= "to be--" . $verb . "[present-ongoing]" ;
	return $s;
	
}


sub splitString_by_period {
	my ( $ss ) = @_;
	my $patt = '[\.!?]' ;
	split ( /$patt/, $ss ) ;
}

sub splitString_by_mdash {
	my ( $ss ) = @_;

	# saved to DOS text (with or without line-breaks) .txt from Word, 
	# mdashes come out as ' - '
	my $patt = ' - ' ;  
	split ( /$patt/, $ss ) ;
}

sub textload {
	my ( $fname ) = @_ ;

	my $md = 0 ;
		$md && print (" textload: fname: <$fname>\n" );
	
	open ( TEXT,   "<  $fname"  ) or die "can't open datafile: $fname";	

	my $onebigstring = "";
	while ( $item = <TEXT> )
  {
		$item =~ s/[\t\r\n]/ /g ;  # protect us from certain characters
		$md && print (" textload: item: <$item>\n" );
		$onebigstring .= $item if ( length($item) > 2 ) ;
	}	

	my @textlines = &splitString_by_period ( $onebigstring ) ;
	#my @textlines = &splitString_by_mdash ( $onebigstring ) ;
	
	my $jj = 0;
	foreach $ii (@textlines) {
		$jj++;
		$md && print ( "storing line--  $jj: <$ii>\n" );
	}

	return @textlines ;
}


#--
#--
#--
#--		Grammar entities
#--
#-- 		'PR' means 'Production Rule'
#--

#called--A
sub A { return ".A." ;}
sub B { return ".B." ;}
sub C { return ".C." ;}
sub D { return ".D." ;}
sub E { return ".E." ;}
sub c { return ".c." ;}
sub e { return ".e." ;}
sub f { return ".f." ;}


@TextLines = ();
@TextLines_sorted = ();
@TextLines_phrases = ();

sub pick_textLine { &pick_rand_elem( @TextLines ) ; }

sub pick_textBlock 
{ 
	return pick_textBlock_ab( 2, 5 ) ;
}
sub pick_textBlockBig 
{ 
	return pick_textBlock_ab( 5, 15 ) ;
}

sub pick_textBlock_ab
{ 
	my @block = () ;
	my ( $a, $b ) = @_ ;
	
	my $md = 0 ;
$md && print ("pick_textBlock_ab: enter...(a: $a, b: $b)\n" ); 
	# pick blocksize ie. number of text lines in the block
	my $blocksize = &random_ab($a, $b) ;
$md && print ("pick_textBlock_ab: blocksize = $blocksize...\n" ); 
	# pick a starting point in the array of TextLines
	#my $startline_i = &random(1, (number-of-lines-in-TextLines) - $blocksize ) ;
	my $startline_i = &random_ab(1, $#TextLines - $blocksize ) ;

$md && print ("pick_textBlock_ab: startline_i = $startline_i...\n" ); 
	# select lines sequentially from the starting point, until enough are picked
	my $i ;
	for ( $i = $startline_i ; $i < $startline_i + $blocksize ; $i++) {
		push ( @block, $TextLines[$i] . ".\n" ) ;
$md && print ("pick_textBlock_ab: picking line : <$TextLines[$i]>\n" ); 
	}

$md && print ("pick_textBlock_ab: return block: @block \n" );
	return @block;
}



# Load text files
#
#  Loading of text files is done by subroutine textload.
#  Internally, this routine splits the textfile using either a period,
#  	my @textlines = &splitString_by_period ( $onebigstring ) ;
#  or dos-text-saved version of the em-dash, ' - '
#  	my @textlines = &splitString_by_mdash ( $onebigstring ) ;
#  
#  Adjust this according to the needs of your input file.
#  

	#my @TextFileList = qw( mindscan.txt akb--3-women-emerge-linguistic-abstract.txt );
	#my @TextFileList = qw( mindscan.txt akb--3-women-emerge-linguistic-abstract.txt );
	#my @TextFileList = qw( apollo-fire-report-original.txt apollo-fire-report-analysis-edited.txt );
	my @TextFileList = qw( what-really-happpened-to-akbender-edited-to-1-txt.txt );

	foreach $ff (@TextFileList) {
		print ( "Loading text file: $ff\n" );
		push @TextLines , &textload( $ff );
	}



#--  try this:
#--
#--		#  						for different rhs items
#--		_  						for subroutines
#--		[nothing] 		literal terminals
#--		[space] 			for different items in the same rhs item 

my $PR_rhs_delim='::=' ;
my $PR_rhs_delim1="#" ;
my $PR_rhs_delim2=' ' ;
my $PR_rhs_sub_patt='^_' ;
my %PR_List ;


# simple test grammar
#
my @PR_ListText0 = (
	'S::= A C A # C B # D _D',
	'A::= B # C',
	'B::= _B # C # C A _B',
	'C::= _A _B # _A',
	'D::= C C # _B'
	#'D::= _C _A _B# _D# _f _A _C _e# _E _f'
	#'A::=A# _B# _C _A _B#D# _defineHierarchy ( _selectDiscourseConnective ,  _biographicalQuery )#e  _A _B# _E _f',
	#'selectDiscourseConnective::= _defineHierarchy (  _biographicalQuery )'
) ;

sub genericFunctionName { &pick_rand_elem( @GenericFunctionNames ) ; }

##--  
##--  Production Rule (PR) format
##--  
##--  	1. general form: '<lhs> ::= <rhs>'
##--  	2.	hashmark '#' used to separate items within the <rhs>
##--  	3.	text items in the <rhs> are interpreted as either
##--  				<lhs> non-terminals  (if the text is found to exist somewhere as an <lhs> )
##--  				sub-routine calls		(if the text begins with an underscore )
##--  				text literals				(otherwise)
##--  
##--  	4. there must exist an <lhs> item 'S', the start-symbol
##-- 		5. single <rhs> items are selected at random as the expansion/rewrite of the <lhs> 
##--  


## grammar PR-rules

my @PR_ListText1 = (
	'S2::= SystemMessage 
	',
	'S1::= GenericFunctionCall ( TextBlock ) 
		# GenericFunctionCall ( CuePhrase ) 
		# TextBlockDiscourseSequence
	',
	'S::= applyDirective 
			# SystemMessage
			# AutomatedReasonClauseList
			# DiscourseNode 
			# defineHierarchy 
			# biographicalQuery  
			# DiscourseStructuredTextPhrase 
			# TextBlockDiscourseSequence
	',
	'TextPhrase ::= " _pick_textLine " # " CuePhrase "',
	'TextBlock ::= _pick_textBlock # _pick_textBlockBig ',
	'TextBlockOrPhrase ::= TextPhrase # TextBlock ',
	'TextBlockDiscourseSequence ::= _selectDiscourseConnective ( TextBlockOrPhrase )
		# _selectDiscourseConnective ( FunctionCallArgModifier [ CuePhrase ]: TextPhrase )
	',
	'DiscourseStructuredTextPhrase ::= _genericFunctionName ( TextPhrase ) 
			# _genericFunctionName ( _genericFunctionName ( TextPhrase ), TextPhrase )
			# _genericFunctionName ( DiscourseStructuredTextPhrase )
			# _genericFunctionName ( TextBlockDiscourseSequence )
	',
	'DiscourseNode::= _selectDiscourseConnective ( DiscourseContent )',
	'DiscourseContent::= GenericFunctionCall 
			# _disambiguate_until
			# _inOrderToComplex {{ _shortCuePhraseList }}
			# verbPhrase 
			# TextBlock
			# DiscourseContent
			# AutomatedReasonClause
	',
	#
	#   AR automated-reasoning elements
	#
	#
	'AutomatedReasonClauseList ::= AutomatedReasonClause 
	',
	'AutomatedReasonClause ::= AR_directive_complex
	',
	'AR_data_dump ::= ACTIVE_RULES: AR_predicate_list',
	'AR_directive ::= AR_verb ( AR_nounverb_phrase )
			# AR_verb ( AR_noun AR_verb AR_noun )
			# AR_directive_verb AR_directive_controller ( AR_nounverb_phrase )
			# AR_directive_verb AR_directive_controller ( AR_noun AR_verb AR_noun )
			# AR_directive_verb AR_directive_controller ( AR_predicate )
			# AR_directive_verb AR_directive_controller ( [ FunctionCallArgModifier ( CuePhrase )] AR_predicate )
	',
	'AR_directive_complex ::=  AR_directive
	',
	'AR_directive_controller ::= UNTIL # WHILE # WHEN # IF', 
	'AR_directive_verb ::= AR_verb # let # try # failwith ',
	'AR_predicate_list ::= 1: AR_predicate ;; 
		# 1: AR_predicate ;; 2: AR_predicate ;; 
		# 1: AR_predicate ;; 2: AR_predicate ;; 3: AR_predicate ;;
		# 1: AR_predicate ;; 2: AR_predicate ;; 3: AR_predicate ;; 4: AR_predicate ;;
	',
	'AR_nounverb_phrase ::= AR_adj AR_noun_plural AR_verb AR_adj AR_noun_plural
			# AR_adj AR_noun_plural AR_verb ( FunctionCallArgModifier AR_noun )
			# AR_adj AR_noun_singular AR_verb_s AR_quantifier AR_adj AR_noun_plural
			# AR_adj AR_noun_singular AR_noun_plural AR_verb AR_quantifier AR_adj AR_noun_plural
	',
	'AR_adj ::= # AR_adj_nonempty',
	'AR_adj_nonempty ::= _getADJ # _VerbalComplexAspect',
	'AR_quantifier ::= # ALL # SOME # MOST_OF # AT_MOST_ONE_OF # NONE_OF',
	'AR_andor ::= AND # OR',
	'AR_if ::= IF ( AR_predicate ) THEN AR_directive
			# IF ( AR_predicate ) THEN AR_directive ELSE AR_directive
			# IF ( AR_predicate ) THEN AR_directive UNLESS ( AR_predicate )
	', 
	'AR_predicate ::= AR_nounverb_phrase 
			# ( AR_predicate AR_andor AR_predicate )
			# NOT( AR_predicate )
			# AR_noun_singular AR_logical_operator AR_noun_plural
			# AR_noun_singular AR_logical_operator ( GenericFunctionCall )
			# GenericFunctionCall # CuePhrase
	',
	'AR_logical_operator ::= equals # in # subset_of # exists # exists_for_all # disjunct_with',
	'AR_noun ::= AR_noun_singular # AR_noun_plural
	',
	'AR_noun_plural ::= contrapositives # ancestors # using_sets # rewrite_sets 
			# hypotheses # rules # current_goals # subterms 
			# successors # predicates # critical_pairs # ground_tuples
			# tuples # oneiric assertions # substitutions
	',
	'AR_noun_singular ::= contrapositive # ancestor # using_set # rewrite_set 
      # hypothesis # rule # current_goal # subterm 
      # successor # predicate # critical_pair # ground_tuple
      # tuple # ultra-trajectory # substitution
  ',
	'AR_verb ::= unify # equalize # expand # skolemize # deepen 
		# assume # deny # define # undefine # promote 
		# rename # failwith # generalize # specialize
		# canonize_with # merge # partition # atomize # satisfy
		# filter # replace # normalize # reduce # inter_reduce
		# substitute # axiomatize
		# match_within # resolve # paramodulate # quantify #instantiate # simplify
		# finitize # eliminate # interpolate # constrain
		# update_goal # assert # find_closure
	',
	'AR_verb_s ::= unifies # equalizes # expands # skolemizes # deepens 
		# assumes # denies # defines # undefines # promotes 
		# renames # fails_with # generalizes # specializes
		# canonizes # merges_with # partitions # atomizes # satisfies
		# filters # replaces # normalizes # reduces # inter_reduces
		# substitutes # axiomatizes
		# matches_within # resolves # paramodulates # quantifies #instantiates # simplifies
		# finitizes # eliminates # interpolates # constrains
		# updates # asserts 
	',
	'AR_exception_report ::= AR_exception # AR_exception # AR_exception AR_recovery',
	'AR_exception ::= [unexpected failure of AR_verb : AutomatedReasonClause ]',
	'AR_recovery ::= ((recovery strategy: AR_directive_complex ))',
	#
	#   various Discourse elements
	#
	#
	'CuePhrase::= _shortCuePhraseList # _longCuePhraseList_AKBender # TextPhrase', 
	'defineHierarchy::= # _defineHierarchy 
				# _defineHierarchy ( _parameterUpdate ==> _ADJ_NOUN_phrase )', 
	'biographicalQuery::= _biographicalQuery',
	'GenericFunctionCall ::= _genericFunctionName ( DiscourseContent ) 
				# _genericFunctionName ( GenericFunctionCall , GenericFunctionCall )
				# _genericFunctionName ( FunctionCallArgModifier DiscourseNode )
	',
	'FunctionCallArgModifier ::= subsuming: 
				# as:
				# enveloping: 
				# denying:
	',
#
#
#   system-level messages
#
	'SystemMessage ::= systemUpdate # AR_data_dump # AR_exception_report # GrandImperative ',
	'applyDirective ::= applyVerbExpr applyAspect ( applyConnector ( textLineList ) )',
	'MedicalDirective::= (* medicalVerb _parameterUpdate *) ',
	'GrandImperative::= { VERB all pluralNOUN ! }',
	'applyAspect ::=   # [ _VerbalComplexAspect ] ',
	'applyConnector ::= _linkage_operator # _selectDiscourseConnective',
	'applyVerbExpr ::= applyVerb # applyVerb FunctionCallArgModifier',
	'applyVerb ::= apply 
		# map # calibrate 
		# iterate 
		# solve_using
		# undefine
		# unify # expand 
	',
	'textLineList ::=  _pick_textLine # ( _pick_textLine , _pick_textLine ) # ( _pick_textLine , _pick_textLine , _pick_textLine )',
	'medicalVerb::= ensure # require # calibrate # avoid # monitor',
	'ExceptionReport ::= **exception encountered: ExceptionType ',
	'ExceptionType ::= _VerbalComplexAspect # ParameterUpdate # AR_exception',
	'ParameterUpdate::= ParameterDump # MedicalDirective # _parameterUpdate ( _NOUN_NOUN_phrase )',
	'ParameterDump::= ((sysvarcheck: ParameterValueList',
	'ParameterValueList::= ParameterValue ; # ParameterValue ; ParameterValue ; ',
	'ParameterValue::= _parameterUpdate ',
	'systemUpdate ::= ExceptionReport # ParameterDump # ParameterUpdate ',
	'VERB::= _getVERB',
	'ADJ::= _getADJ',
	'NOUN::= _getNOUN',
	'pluralNOUN::= _getpluralNOUN',
	'verbPhrase::= VERB ( _VerbalComplexAspect ) ADJ NOUN'
) ;

##--  notes re: noun-phrase
##--  		
##--  	im_verb   eg. expand  ("imperative verb")
##--  	sg_verb   eg. expands
##--  	sg_noun		eg. predicate
##--  	pl_noun		eg. predicates
##--  
##--  
##--  sg_noun						(eg. tuple )
##--  sg_noun-sg_noun		(eg. rule-tuples )
##--  sg_noun-pl_noun		(eg. subterm ground_tuples )
##--  im_verb pl_noun		(eg. finitize ancestors )
##--  im_verb sg_noun-pl_noun
##--  sg_noun sg_verb noun-phrase
##--  noun-verbal-phrase ::= im_verb sg_noun-pl_noun # sg_noun sg_verb noun-phrase
##--  condition ::= condition_op noun-verbal-phrase
##--  condition_op ::= IF # UNTIL # WHEN # WHILE
##--  



# set which PR list to use
#
my @PR_ListText = @PR_ListText1 ;



# eval conditionally -- using $PR_rhs_sub_patt  ie. using leading '_'
#
sub ev_ {
	my ( $ee ) = @_ ;
	my $patt = $PR_rhs_sub_patt ;

#---nondebug----#
	($ee =~ m/$patt/) ? eval(substr($ee,1)) : $ee ;

#---debug----#
##==	my $rr = ($ee =~ m/$patt/) ;
##==	my $ss = "";
##==
##==		print "ev_: patt: $patt  vs. $ee  -- rr: $rr" ;
##==
##==	$ss = $ee ;
##==	if ( $rr )
##==	{
##==		print "-- \t\tmatch -- evaling: <" . substr($ee,1) . ">\n" ;
##==		$ss = eval(substr($ee,1)) ;
##==	}
##==	else 
##==	{
##==		print "-- \t\tno match\n" ;
##==	}
##==
##==	print ( "ev_: return: $ss\n" );
##==	$ss ;
}

#  epr : evaluate production-rule
#
sub epr 
{
	my ( $prList_ref, @rhs ) = @_ ;

	my $md = 0 ;
	my $retVal = "";

	$md && print ("epr: enter...\n" ); 
	$md && print ("epr: prList_ref: $prList_ref \n" );
	$md && print ("epr: rhs: @rhs\n" );

	# select an item randomly  
	#  (***alter algorithm here to use a pdf assoc'd with the PR)
	#
	my $rhs_item = &pick_rand_elem( @rhs ) ;
	my $ss = "";
	$ss .= "epr: rhs_item:<" ;
	$ss .= $rhs_item ; 
	$ss .= ">\n" ;
	$md && print $ss;

	# look up $rhs_item in the grammar's list of left-hand-sides

	if ( exists $$prList_ref{$rhs_item} )
	{
	# if found -- will be handled at a higher level
		$md && print ( "epr: exists is TRUE\n" );
		my $ll = $$prList_ref{$rhs_item} ;
     $md && print "epr: lookup: <" . $ll . "> \n" ;
	}
	else
	{
	# if not found:
	#   split using approp. delimiter, and call ev_() on each item
		$md && print ( "epr: exists is NOT TRUE\n" );
		$md && print ( "epr: eval'ing the sub-items...\n" );

	# 'A::=A# _B# _C _A _B#D# _D _A _B#e  _A _B# _E _f',
		my @sub_items = split( /$PR_rhs_delim2/, $rhs_item ) ;
		my $rs="";
		my $si="";
		$md && print ( "epr: sub-items after split: @sub_items\n" );
		foreach $si ( @sub_items ) {
			$md && print ( "epr: about to eval sub_item: $si\n" );
			# ignore any first, empty item after the split
			$rs .= &ev_( $si ) if ( length($si) > 0 ) ;
		}
		$md && print ( "epr: return: $rs\n" );
		$retVal = $rs ;
	}

	return $retVal ;
}

#  return list of values rather than single string
#
#
sub epr2 {
	my ( $usedrules_ref, $lhs_item, $prList_ref, @rhs ) = @_ ;

	my $md = 0 ;
	my @retVal = ();

	$md && print ("epr2: enter...\n" ); 
	$md && print ("epr2: prList_ref: $prList_ref \n" );
	$md && print ("epr2: rhs: @rhs\n" );

	# select an item randomly  
	#  (***alter algorithm here to use a pdf assoc'd with the PR)
	#
	my $rhs_item = &pick_rand_elem( @rhs ) ;
	my $ss = "";
	$ss .= "epr2: rhs_item:<" ;
	$ss .= $rhs_item ; 
	$ss .= ">\n" ;
	$md && print $ss;

	$md && print ( "epr2: using PR: <" . $lhs_item . $PR_rhs_delim . $rhs_item . ">\n" );
	push ( @$usedrules_ref, $lhs_item . $PR_rhs_delim . $rhs_item ) ;

	# look up $rhs_item in the grammar's list of left-hand-sides

	if ( exists $$prList_ref{$rhs_item} )
	{
	# if found -- will be handled at a higher level
		$md && print ( "epr2: exists is TRUE\n" );
		my $ll = $$prList_ref{$rhs_item} ;
     $md && print "epr2: lookup: <" . $ll . "> \n" ;
	}
	else
	{
	# if not found:
	#   split using approp. delimiter, and call ev_() on each item
		$md && print ( "epr2: exists is NOT TRUE\n" );
		$md && print ( "epr2: eval'ing the sub-items...\n" );

	# 'A::=A# _B# _C _A _B#D# _D _A _B#e  _A _B# _E _f',
		my @sub_items = split( /$PR_rhs_delim2/, $rhs_item ) ;
		my $rs="";
		my $si="";
		$md && print ( "epr2: sub-items after split: @sub_items\n" );
		foreach $si ( @sub_items ) {
			$md && print ( "epr2: about to eval sub_item: $si\n" );
			# ignore any first, empty item after the split
			push (@retVal, &ev_( $si )) if ( length($si) > 0 ) ;
		}
		$md && print ( "epr2: return: items: <@retVal>\n" );
	}

	return @retVal ;
}


my @PR_RulesUsed ;

sub genGrammar {

	my $md = 0 ;  # myDebug flag

	my $ss_delim = '%%' ;
	my $startSymbol = 'S' ;
	my $ss = $ss_delim . $startSymbol . $ss_delim  ;  #  'S' is the start-symbol
	my $rewrite_count = 0 ;

	my @next_ss ;
	my @ss_items ;
	my $ss_iteration = 0 ;

	@PR_RulesUsed = () ;		# will be filled out by epr2 with each PR rule used


	while (1) {
	
		$ss_iteration++;
		# split $ss using $ss_delim
		@ss_items = split( $ss_delim, $ss ) ;
		$md && print( "gen: ----------- iteration: $ss_iteration\n" );
		$md && print( "gen: -----------  ss      : <$ss> \n" );
		$md && print( "gen: -----------  ss_items: <@ss_items> \n" );
		$rewrite_count = 0 ;
		my $rewrite_item = "" ;
		my @rewrite_items = () ;

		foreach $ss_item ( @ss_items ) {
			@rewrite_items = () ;
			$md && print( "\tgen: got 1 ss_item: <$ss_item> \n" );
			next if ( length($ss_item) <= 0 ) ;

			# check for a lhs entry for the item from the PR_List
			if ( exists $PR_List{$ss_item} ) {
				$md && print( "\tgen: ss_item has lhs...\n" );
				##--$rewrite_item = &epr( \%PR_List, @{ $PR_List{$ss_item} } );
				#@rewrite_items = &epr2( \@PR_RulesUsed, $ss_item, \%PR_List, @{ $PR_List{$ss_item} } );
				push ( @rewrite_items , &epr2( \@PR_RulesUsed, $ss_item, \%PR_List, @{ $PR_List{$ss_item} } ) );
				$rewrite_count++ ;
				#$md && print( "\tgen: ...rewrite as: $rewrite_item\n" );
				$md && print( "\tgen: ...rewrite as: <@rewrite_items>\n" );
			}
			else {
				$md && print( "\tgen: ss_item has no lhs...\n" );
				##--$rewrite_item = $ss_item ;   # ie. no further rewrite done
				if ( length( $ss_item ) > 0 ) {
					push @rewrite_items, $ss_item ;   # ie. no further rewrite done
				}
				$md && print( "\tgen: ...rewrite as itself: <$ss_item>\n" );
			}

			##--$md && print( "\tgen: ...push rewrite_item: <$rewrite_item>\n" );
			##--if ( length( $rewrite_item ) > 0 ) {
			##--	push @next_ss, $rewrite_item ;
			##--}

			if ( $#rewrite_items >= 0 ) {
				$md && print( "\tgen: ...push rewrite_items: <@rewrite_items>\n" );
				push @next_ss, @rewrite_items ;
			}
		}

		$md && print( "gen: got next_ss: <@next_ss>\n" );
		$ss = join( $ss_delim, @next_ss ) ;
		$md && print( "gen:  --- rewrite_count: $rewrite_count\n" );

		$md && print( "gen:  ($ss_iteration) update ss to: <$ss>\n\n\n" );

		# delete all entries from @next_ss  ;
		@next_ss = () ;
		last if ( $rewrite_count == 0 ) ;

	}


	# substitute away the SS delimiter
	$ss =~ s/$ss_delim/ /g ;

	$md && print( "gen:  output: <$ss>\n" );


	if ( $md ) {
		print( "gen:  rules used: \n" );
		foreach $r ( @PR_RulesUsed ) { print "\t\t$r\n"; }
		print( "gen:  finaloutput: <$ss>\n" );
	}

	return $ss ;

}


sub testgrammar 
{

	my $md = 0 ;

	# Parse PR list text into hash-table form
	#
	foreach $pr ( @PR_ListText ) {
		my ($lhs, $rhs) = split( /$PR_rhs_delim/, $pr ) ;
		$lhs =~ s/[ \t\n]//g ;
		$rhs =~ s/[\t\n]//g ;  # careful -- we need spaces on the rhs.
		my @psels = split( /$PR_rhs_delim1/, $rhs ) ;
		$PR_List{$lhs} = [ @psels ] ;
		$md && print ( "testgrammar: PR --  $lhs $PR_rhs_delim " . join($PR_rhs_delim1, @psels) . "\n" );
	}

	#  test evaluation of each parsed PR list
	#
	$md && print "---------\n" ;

		foreach $rr ( keys %PR_List ) 
		{
     #$md && print "testgrammar: key $rr: " . ((exists $PR_List{$rr} ) ? "exists" : "not exists" ) . "\n" ;
     #$md && print "testgrammar: key $rr: value: @{ $PR_List{$rr} }\n" ;
     #$md && print "testgrammar: PR--  $rr " . $PR_rhs_delim . "  @{ $PR_List{$rr} }\n" ;
			#$md && &epr( \%PR_List, @{ $PR_List{$rr} } );
 		}


		$gg = &genGrammar ;
		print( "==> " . $gg . "\n" ); 

}

sub test_epr_split {
	my $s1 = '(A)  # ( _B )# _C _A _B		#D# _D _A _B#e _A _B# _E _f' ;
	my $rhs_delim1 = '#' ;
	my $rhs_delim2 = ' ' ;

	print ( "s1: <" . $s1 . ">\n" );
	my @a0 = split( $rhs_delim1, $s1 ) ; 

	foreach $jj ( @a0 ) {
		print ( "jj-item: <" . $jj . ">\n" );
		my @aa = split( $rhs_delim2, $jj ) ;
		foreach $ii ( @aa ) {
			print ( "\tii-item: <" . $ii . ">\n" );
			print ( "\tev_: <" . &ev_($ii) . ">\n" );
		}
	}

}

sub testsplit {

#my $text << 'EOT1';

	#print <<EOT1;
	my $text = <<EOT1;
 	Dispell locked encodements!

	Regain insight upliftment!

	Celebrate pure intent!

 Startling new ascension techniques are now available from Higher Light Pro-
totypes. Thru the healing influence of accelerated liberation resonance, you 
will clear you DNA of the seed fears planted by the shadow-self. Using our 
unique approach to crystal revisioning, you will anchor the density bombard-
ments caused by destructive focus. 

Meditating in our xenon-infusion Process CavityTM reconnection chamber 
(designed by our partnering team of Venusian Intuitives), you will learn to 
access planetary manifestation powers, to embrace your emergent Light Quo-
tient, and to restructure your soul blueprint for cocreative, unconditional 
entrainment.

 Supplemented with private vortex tours and monatomic deep colonic cleans-
ing exercises, you will study the liberation Gases and their birthing relation-
ship to your DENSITY-REALM subpersonalities. Specially trained neo-tantric 
body-Wisdom Workers will be available.

The resulting monadic shifts and open-ended frequency promotions will 
enhance your holographic recovery. You will awaken evolutionary modalities 
that will allow direct connection to the subtle magnetics of the Oversoul.

Everyone concerned with their destiny convergence is encouraged to enroll 
immediately. This promises to be our biggest, most loving Vision Festival ever!

Its bound to be sold out very soon! 

EOT1

	print( "text: $text\n" );

	#$text =~ s/\n\s+/ /g;  # fix continuation lines
	$text =~ s/\n/ /g;  # fix continuation lines
	my $patt = '[\.!]' ;
	my @textbits = split ( /$patt/, $text ) ;

	foreach $tt ( @textbits ) {
		print ( "tt: <" . $tt . ">\n" );
	}

}

#
# main
#
#
#
#


## ----- main

	srand(  time ^ $$ ) ;

	







	for ( 1..400 ) { &testgrammar; sleep 1; }

## ----- end main


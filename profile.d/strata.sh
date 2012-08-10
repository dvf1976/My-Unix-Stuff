if [ -z $ENV ] 
    then
    export ENV='dev'
fi

`cat ~/strata.conf | grep STRATA_USER`;
`cat ~/strata.conf | grep -i $ENV -A 2 | grep PASS`;
`cat ~/strata.conf | grep -i $ENV -A 2 | grep HOST`;
alias entitlement="curl -v -k -u $STRATA_USER:$STRATA_PASS -X GET -H 'Accept: application/json' $STRATA_HOST/rs/solutions?keyword=entitlement"
alias get_solution="curl -v -k -u $STRATA_USER:$STRATA_PASS -X GET -H 'Accept: application/json' $STRATA_HOST/rs/solutions/113783"
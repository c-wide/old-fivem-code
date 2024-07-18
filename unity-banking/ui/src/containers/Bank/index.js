import React from 'react';
import { useSelector } from 'react-redux';

import { makeStyles } from '@material-ui/core/styles';

import Grid from '@material-ui/core/Grid';

import InfoCard from './InfoCard';
import QuickTransfer from './QuickTransfer';
import TransactionHistory from './TransactionHistory';
import BigButton from './BigButton';

const useStyles = makeStyles({
  root: {
    padding: '10px',
  },
});

export default () => {
  const disableDeposit = useSelector(state => state.bank.disableDeposit);
  const classes = useStyles();

  return (
    <div>
      <Grid className={classes.root} container spacing={1}>
        <Grid item xs={3}>
          <InfoCard />
        </Grid>
        <Grid item xs={3}>
          <QuickTransfer />
        </Grid>
        <Grid item xs={6}>
          <TransactionHistory />
        </Grid>
        <Grid item xs={4}>
          <BigButton label="Withdraw" />
        </Grid>
        <Grid item xs={4}>
          <BigButton label="Deposit" disableDeposit={disableDeposit} />
        </Grid>
        <Grid item xs={4}>
          <BigButton label="Transfer" />
        </Grid>
      </Grid>
    </div>
  );
};

import React from 'react';
import { useSelector } from 'react-redux';

import { makeStyles } from '@material-ui/core/styles';

import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import Typography from '@material-ui/core/Typography';
import Divider from '@material-ui/core/Divider';
import Button from '@material-ui/core/Button';

import AccountBalanceWalletIcon from '@material-ui/icons/AccountBalanceWallet';
import AccountBalanceIcon from '@material-ui/icons/AccountBalance';

import Nui from '../../util/Nui';

const useStyles = makeStyles({
  divider: {
    marginBottom: '5px',
  },
  card: {
    background: '#333333',
    height: 208,
    maxHeight: 208,
  },
  dollarSign: {
    color: '#fafafa',
    verticalAlign: 'super',
    marginRight: '1.5px',
  },
  buttonDiv: {
    marginTop: '12px',
  },
  buttonSpacing: {
    marginTop: '5px',
  },
});

export default () => {
  const playerName = useSelector(state => state.bank.playerName);
  const accountBalance = useSelector(state => state.bank.accountBalance);
  const disableDeposit = useSelector(state => state.bank.disableDeposit);
  const classes = useStyles();

  const quickWithdraw = async (event, amount = 1000) => {
    await Nui.send('withdraw', { amount });
  };

  const quickDeposit = async () => {
    await Nui.send('deposit');
  };

  return (
    <Card raised className={classes.card}>
      <CardContent>
        <Typography align="center" gutterBottom>
          Welcome, {`${playerName.firstname}`}
        </Typography>
        <Divider className={classes.divider} />
        <Typography className={classes.dollarSign} variant="subtitle2">
          Account Balance:
        </Typography>
        <Typography
          className={classes.dollarSign}
          display="inline"
          variant="subtitle2"
        >
          $
        </Typography>
        <Typography display="inline" variant="h5" gutterBottom>
          {accountBalance.toLocaleString()}
        </Typography>
        <div className={classes.buttonDiv}>
          <Button
            startIcon={<AccountBalanceWalletIcon />}
            fullWidth
            variant="contained"
            color="primary"
            onClick={quickWithdraw}
          >
            Withdraw $1000
          </Button>
          <Button
            startIcon={<AccountBalanceIcon />}
            fullWidth
            variant="contained"
            color="primary"
            className={classes.buttonSpacing}
            onClick={quickDeposit}
            disabled={disableDeposit}
          >
            Deposit All
          </Button>
        </div>
      </CardContent>
    </Card>
  );
};

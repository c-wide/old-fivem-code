import React from 'react';
import { useSelector } from 'react-redux';

import { makeStyles } from '@material-ui/core/styles';

import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import Typography from '@material-ui/core/Typography';
import Divider from '@material-ui/core/Divider';
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemText from '@material-ui/core/ListItemText';
import ListItemIcon from '@material-ui/core/ListItemIcon';
import TransferWithinAStationIcon from '@material-ui/icons/TransferWithinAStation';
import AccountBalanceWalletIcon from '@material-ui/icons/AccountBalanceWallet';
import AccountBalanceIcon from '@material-ui/icons/AccountBalance';

const useStyles = makeStyles({
  card: {
    background: '#333333',
    height: 208,
    maxHeight: 208,
    marginLeft: 6,
    overflow: 'auto',
    '&::-webkit-scrollbar': {
      width: '0.8em',
    },
    '&::-webkit-scrollbar-track': {
      boxShadow: 'inset 0 0 6px rgba(0,0,0,0.00)',
      webkitBoxShadow: 'inset 0 0 6px rgba(0,0,0,0.00)',
    },
    '&::-webkit-scrollbar-thumb': {
      backgroundColor: 'rgba(0,0,0,.1)',
      outline: '1px solid slategrey',
    },
  },
  listDivider: {
    marginLeft: -20,
    marginRight: 8,
  },
  listIcons: {
    color: '#fafafa',
  },
});

export default () => {
  const transactionHistory = useSelector(
    state => state.bank.transactionHistory,
  );

  const classes = useStyles();

  const renderedItems = () =>
    Object.entries(transactionHistory).map(([key, value]) => {
      let icon = null;

      if (
        value.transaction.includes('received') ||
        value.transaction.includes('sent')
      ) {
        icon = <TransferWithinAStationIcon className={classes.listIcons} />;
      } else if (value.transaction.includes('deposit')) {
        icon = <AccountBalanceIcon className={classes.listIcons} />;
      } else {
        icon = <AccountBalanceWalletIcon className={classes.listIcons} />;
      }

      return (
        <ListItem key={key} divider>
          <ListItemIcon>{icon}</ListItemIcon>
          <Divider
            className={classes.listDivider}
            orientation="vertical"
            flexItem
          />
          <ListItemText primary={value.transaction} />
        </ListItem>
      );
    });

  return (
    <Card raised className={classes.card}>
      <CardContent>
        <Typography align="center" gutterBottom>
          Transaction History
        </Typography>
        <Divider />
        <List dense disablePadding>
          {renderedItems()}
        </List>
      </CardContent>
    </Card>
  );
};

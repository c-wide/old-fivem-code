import React, { useState } from 'react';
import { useSelector, useDispatch } from 'react-redux';

import { makeStyles } from '@material-ui/core/styles';

import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import Typography from '@material-ui/core/Typography';
import Divider from '@material-ui/core/Divider';
import Avatar from '@material-ui/core/Avatar';
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemText from '@material-ui/core/ListItemText';

import TransferDialog from '../../Components/TransferDialog';

const useStyles = makeStyles(theme => ({
  card: {
    overflow: 'auto',
    background: '#333333',
    height: 208,
    maxHeight: 208,
    width: 220,
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
  divider: {
    marginBottom: '5px',
  },
  small: {
    width: theme.spacing(3),
    height: theme.spacing(3),
    marginRight: theme.spacing(1),
    color: '#fafafa',
    backgroundColor: '#1a7cc1',
  },
}));

export default () => {
  const [open, setOpen] = useState(false);

  const dispatch = useDispatch();

  const nearbyPlayersNames = useSelector(
    state => state.bank.nearbyPlayersNames,
  );

  const classes = useStyles();

  const handleClick = key => {
    dispatch({ type: 'SET_ACCOUNT_ID', payload: key });
    setOpen(true);
  };

  const renderedItems = () =>
    Object.entries(nearbyPlayersNames).map(([key, value]) => (
      <ListItem onClick={() => handleClick(key)} key={key} divider button>
        <Avatar className={classes.small}>{value.firstname.charAt(0)}</Avatar>
        <ListItemText primary={`${value.firstname} ${value.lastname}`} />
      </ListItem>
    ));

  return (
    <>
      <Card raised className={classes.card}>
        <CardContent>
          <Typography align="center" gutterBottom>
            Quick Transfer
          </Typography>
          <Divider className={classes.divider} />
          <List disablePadding>{renderedItems()}</List>
        </CardContent>
      </Card>
      <TransferDialog
        open={open}
        setOpen={setOpen}
        title="Transfer Funds"
        quickTransfer
      />
    </>
  );
};

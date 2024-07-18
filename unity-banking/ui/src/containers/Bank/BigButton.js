import React, { useState } from 'react';

import { makeStyles } from '@material-ui/core/styles';
import Button from '@material-ui/core/Button';

import StandardDialog from '../../Components/StandardDialog';
import TransferDialog from '../../Components/TransferDialog';

const useStyles = makeStyles({
  root: {
    height: 120,
    backgroundColor: '#333333',
    color: '#fafafa',
    '&:hover': {
      backgroundColor: '#1a7cc1',
    },
  },
});

export default ({ label, disableDeposit }) => {
  const [standardDialogOpen, setStandardDialogOpen] = useState(false);
  const [transferDialogOpen, setTransferDialogOpen] = useState(false);

  const classes = useStyles();

  return (
    <>
      <Button
        onClick={() =>
          label === 'Transfer'
            ? setTransferDialogOpen(true)
            : setStandardDialogOpen(true)
        }
        className={classes.root}
        fullWidth
        variant="contained"
        disabled={disableDeposit}
      >
        {label}
      </Button>
      <StandardDialog
        open={standardDialogOpen}
        setOpen={setStandardDialogOpen}
        title={`${label} Funds`}
      />
      <TransferDialog
        open={transferDialogOpen}
        setOpen={setTransferDialogOpen}
        title={`${label} Funds`}
        accountId=""
      />
    </>
  );
};

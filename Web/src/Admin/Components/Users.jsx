import React, { useEffect, useState } from 'react'
import { DataGrid } from '@mui/x-data-grid';
// import { Button, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, Typography } from '@mui/material';
// import DeleteIcon from '@mui/icons-material/Delete';
import {Typography} from '@mui/material'
import { db } from '../../config/firebase';
import { collection, getDocs } from 'firebase/firestore';

const Users = () => {

    // const [open, setOpen] = useState(false);
    const [userData, setUserData] = useState([]);


    // const handleClickOpen = () => {
    //     setOpen(true);
    // };

    // const handleClose = () => {
    //     setOpen(false);
    // };

    const loadUsers = async () => {
        try {
            const querySnapshot = await getDocs(collection(db, "users"));
            const userDatas = querySnapshot.docs.map((doc, index) => ({ id: doc.id, index: index + 1, ...doc.data() }));
            setUserData(userDatas);
        } catch (error) {
            console.error('Error getting documents: ', error);
        }
    };

    useEffect(() => {
        loadUsers();
    }, []);



    const columns = [
        { field: 'index', headerName: 'ID', flex: 1 },
        {
            field: 'name',
            headerName: 'NAME',
            flex: 3,
            renderCell: (params) => {
                const { prefix, name } = params.row;
                return (
                    <div>
                        {prefix && <span>{prefix}. </span>}
                        {name}
                    </div>
                );
            },
        },
        { field: 'gender', headerName: 'GENDER', flex: 3 },
        {
            field: 'email',
            headerName: 'EMAIL',
            flex: 3,
            sortable: false,

        },
        {
            field: 'dateOfBirth',
            headerName: 'Date Of Birth',
            flex: 3,
        },
        {
            field: 'address',
            headerName: 'ADDRESS',
            flex: 3,
            sortable: false,

        },

        {
            field: 'phone',
            headerName: 'PHONE NUMBER',
            description: 'This column has a value getter and is not sortable.',
            sortable: false,
            flex: 4,
        },
        // {
        //     field: "action",
        //     headerName: "Action",
        //     flex:2,
        //     renderCell: (params) => {
        //         return (
        //             <>
        //                 <DeleteIcon
        //                     className="divListDelete"
        //                     onClick={() => handleClickOpen(params)}
        //                 />
        //             </>
        //         );
        //     },
        // },
    ];




    return (
        <>
            <div>
                <Typography variant="h4" gutterBottom>
                    Users
                </Typography>
                <div style={{ height: 400, width: '100%' }}>
                    <DataGrid
                        rows={userData}
                        columns={columns}
                        initialState={{
                            pagination: {
                                paginationModel: { page: 0, pageSize: 5 },
                            },
                        }}
                        pageSizeOptions={[5, 10]}
                    />
                </div>
            </div>
            {/* <Dialog
                open={open}
                onClose={handleClose}
                aria-labelledby="alert-dialog-title"
                aria-describedby="alert-dialog-description"
            >
                <DialogTitle id="alert-dialog-title">
                    {"Confirm Delete"}
                </DialogTitle>
                <DialogContent>
                    <DialogContentText id="alert-dialog-description">
                        Are you sure to delete this user permanenently
                    </DialogContentText>
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleClose}>Disagree</Button>
                    <Button onClick={handleClose} autoFocus>
                        Agree
                    </Button>
                </DialogActions>
            </Dialog> */}
        </>
    )
}

export default Users
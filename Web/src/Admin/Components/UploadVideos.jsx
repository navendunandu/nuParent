import React, { useEffect, useState } from 'react'
import { DataGrid } from '@mui/x-data-grid';
import { Box, Button, FormControl, InputLabel, MenuItem, Select, Stack, TextField, Typography, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, } from '@mui/material';
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import { styled } from '@mui/material/styles';
import DeleteIcon from '@mui/icons-material/Delete';
import VisibilityIcon from '@mui/icons-material/Visibility';
import { db, storage } from '../../config/firebase';
import { addDoc, collection, getDocs, deleteDoc, doc } from 'firebase/firestore';
import { ref, uploadBytesResumable, getDownloadURL } from "firebase/storage";



const UploadVideos = () => {


    const [open, setOpen] = useState(false);
    // const [openPlayer, setOpenPlayer] = useState(false);
    const [uploadVideosData, setUploadVideosData] = useState([]);
    const [videoTitle, setVideoTitle] = useState('');
    const [video, setVideo] = useState([]);
    const [selectedRow, setSelectedRow] = useState(null);
    const [ageData, setAgeData] = useState([]);
    const [age, setAge] = useState('');
    //const [singleVideo, setSingleVideo] = useState([]);

    const handleClickOpen = (params) => {
        setSelectedRow(params);
        setOpen(true);
    };
    // const handleClickOpenVideo = (params) => {  

    //     setSingleVideo(params);
    //     setOpenPlayer(true);
    // };



    const handleClose = () => {
        setOpen(false);
    };

    // const handleClosePlayer = () => {
    //     setOpenPlayer(false)
    // }





    const addUploadVideo = async () => {
        try {
            const type = video.type;

            if (!type || !type.startsWith('video/')) {
                alert('Invalid file type. Please upload a video.');
                return; 
            }


            const storageRef = ref(storage, 'Video/' + video.name);
            await uploadBytesResumable(storageRef, video);
            const videoUrl = await getDownloadURL(storageRef).then((downloadURL) => {
                return downloadURL
            });
            await addDoc(collection(db, "uploadVideo"), { videoTitle, videoUrl, age })
            loadUploadVideo();
            setAge('')
            setVideoTitle('')
            setVideo('')
        } catch (error) {
            console.error('Error adding document: ', error);
        }
    };

    const loadUploadVideo = async () => {
        try {
            const querySnapshot = await getDocs(collection(db, "uploadVideo"));
            const uploadVideo = querySnapshot.docs.map((doc, index) => ({ id: doc.id, index: index + 1, ...doc.data() }));
            setUploadVideosData(uploadVideo);
        } catch (error) {
            console.error('Error getting documents: ', error);
        }


    };

    const deleteUploadVideo = async () => {
        try {
            if (selectedRow) {
                await deleteDoc(doc(db, "uploadVideo", selectedRow.id));
                setOpen(false);
                setSelectedRow(null)
                loadUploadVideo();
            }
        } catch (error) {
            console.error('Error removing document: ', error);
        }
    };

    const loadAgeGroups = async () => {
        try {
            const querySnapshot = await getDocs(collection(db, "ageGroups"));
            const ageGroups = querySnapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
            setAgeData(ageGroups);
        } catch (error) {
            console.error('Error getting documents: ', error);
        }


    };



    useEffect(() => {
        loadUploadVideo();
        loadAgeGroups();
    }, []);



    const columns = [
        { field: 'index', headerName: 'ID', flex: 1 },

        {
            field: 'videoTitle',
            headerName: 'Videos',
            flex: 3,
        },
        {
            field: 'videoUrl',
            headerName: 'Videos',
            flex: 3,
            renderCell: (params) => {
                return (
                    <>
                        <VisibilityIcon
                            className="divListDelete"
                           // onClick={() => handleClickOpenVideo(params)}
                        />
                    </>
                );
            },
        },
        {
            field: "action",
            headerName: "Action",
            flex: 1,
            renderCell: (params) => {
                return (
                    <>
                        <DeleteIcon
                            className="divListDelete"
                            onClick={() => handleClickOpen(params)}
                        />
                    </>
                );
            },
        },
    ];



    const VisuallyHiddenInput = styled('input')({
        clip: 'rect(0 0 0 0)',
        clipPath: 'inset(50%)',
        height: 1,
        overflow: 'hidden',
        position: 'absolute',
        bottom: 0,
        left: 0,
        whiteSpace: 'nowrap',
        width: 1,
    });

    return (
        <>
            <div>
                <Typography variant="h4" gutterBottom>
                    Upload Video
                </Typography>
                <Box
                    component="form"
                    sx={{
                        '& > :not(style)': { m: 4, width: '100%' },
                    }}
                    noValidate
                    autoComplete="off"
                >

                    <Stack spacing={2} direction="row" >
                        <FormControl sx={{ minWidth: 120 }}>
                            <InputLabel id="demo-simple-select-label">Age</InputLabel>
                            <Select
                                labelId="demo-simple-select-label"
                                id="demo-simple-select"
                                value={age}
                                label="Age"
                                onChange={(event) => setAge(event.target.value)}
                            >
                                {
                                    ageData.map((doc, key) => (
                                        <MenuItem key={key} value={doc.id}>{doc.age}</MenuItem>

                                    ))
                                }
                            </Select>
                        </FormControl>
                        <TextField id="outlined-basic" label="Video Title" variant="outlined" onChange={(event) => setVideoTitle(event.target.value)} />
                        <Button component="label" variant="contained" startIcon={<CloudUploadIcon />} onChange={(event) => setVideo(event.target.files[0])}>
                            Upload file
                            <VisuallyHiddenInput type="file" />
                        </Button>

                        <Button variant="contained" sx={{ width: 150 }} onClick={addUploadVideo}>Submit</Button>
                    </Stack>

                </Box>
                <div style={{ height: 400, width: '100%' }}>
                    <DataGrid
                        rows={uploadVideosData}
                        columns={columns}
                        initialState={{
                            pagination: {
                                paginationModel: { page: 0, pageSize: 5 },
                            },
                        }}
                        pageSizeOptions={[5, 10]}
                        checkboxSelection
                    />
                </div>
            </div>
            <Dialog
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
                    <Button onClick={deleteUploadVideo} autoFocus>
                        Agree
                    </Button>
                </DialogActions>
            </Dialog>
            {/* <Dialog
                open={openPlayer}
                onClose={handleClosePlayer}
                aria-labelledby="alert-dialog-title"
                aria-describedby="alert-dialog-description"
            >
           
            </Dialog> */}
        </>
    )
}

export default UploadVideos
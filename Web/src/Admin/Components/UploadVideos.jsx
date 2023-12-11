import React, { useEffect, useState } from 'react'
import { DataGrid } from '@mui/x-data-grid';
import { Box, Button, FormControl, InputLabel, MenuItem, Select, Stack, TextField, Typography, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, } from '@mui/material';
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import { styled } from '@mui/material/styles';
import DeleteIcon from '@mui/icons-material/Delete';
import VisibilityIcon from '@mui/icons-material/Visibility';
import { db, storage } from '../../config/firebase';
import { addDoc, collection, getDocs, deleteDoc, doc } from 'firebase/firestore';
import { ref, uploadBytesResumable, getDownloadURL, deleteObject } from "firebase/storage";



const UploadVideos = () => {


    const [open, setOpen] = useState(false);
    const [openPlayer, setOpenPlayer] = useState(false);
    const [uploadVideosData, setUploadVideosData] = useState([]);
    const [videoTitle, setVideoTitle] = useState('');
    const [video, setVideo] = useState(null);
    const [selectedRow, setSelectedRow] = useState(null);
    const [ageData, setAgeData] = useState([]);
    const [age, setAge] = useState('');
    const [singleVideo, setSingleVideo] = useState([]);

    const [videoTitleError, setVideoTitleError] = useState(false);
    const [ageError, setAgeError] = useState(false);

    const handleClickOpen = (params) => {
        setSelectedRow(params);
        setOpen(true);
    };
    const handleClickOpenVideo = (params) => {

        setSingleVideo(params.row.videoUrl);
        setOpenPlayer(true);
    };



    const handleClose = () => {
        setOpen(false);
    };

    const handleClosePlayer = () => {
        setOpenPlayer(false)
    }


    const generateRandomName = (prefix) => {
        const randomString = Math.random().toString(36).substring(2, 8);
        const timestamp = new Date().getTime();
        return `${prefix}_${randomString}_${timestamp}`;
    }




    const addUploadVideo = async () => {
        if (!videoTitle) {
            setVideoTitleError(true);
            return;
        }
        if (!age) {
            setAgeError(true);
            return;
        }

        setVideoTitleError(false);
        setAgeError(false);
        try {
            const type = video.type;
            const metadata = {
                contentType: video.type
            };

            if (!type || !type.startsWith('video/')) {
                alert('Invalid file type. Please upload a video.');
                return;
            }


            const randomName = generateRandomName(video.name);
            const storageRef = ref(storage, `Video/${randomName}`);
            await uploadBytesResumable(storageRef, video, metadata);
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
                const filePath = selectedRow.row.videoUrl
                const fileRef = ref(storage, filePath);
                await deleteObject(fileRef);
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
            headerName: 'Video Title',
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
                            onClick={() => handleClickOpenVideo(params)}
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
                                onChange={(event) => {
                                    setAge(event.target.value);
                                    setAgeError(false); // Clear error when age is selected
                                }}
                                error={ageError}
                            >
                                {
                                    ageData.map((doc, key) => (
                                        <MenuItem key={key} value={doc.id}>{doc.age}</MenuItem>

                                    ))
                                }
                            </Select>
                        </FormControl>
                        <TextField id="outlined-basic" label="Video Title" variant="outlined" value={videoTitle} onChange={(event) => {
                                setVideoTitle(event.target.value);
                                setVideoTitleError(false); // Clear error when video title is entered
                            }}
                            error={videoTitleError}
                        />
                        <Button component="label" variant="contained" startIcon={<CloudUploadIcon />} onChange={(event) => setVideo(event.target.files[0])}>
                            {video ? (video.name.length > 20 ? video.name.slice(0, 20) + "..." : video.name) : "Upload"}


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
            <Dialog
                open={openPlayer}
                onClose={handleClosePlayer}
                aria-labelledby="responsive-dialog-title"

            >


                <video controls width="300px" height="auto">

                    <source src={singleVideo} />
                    Your browser does not support the video tag.
                </video>
                <Button onClick={handleClosePlayer} sx={{ color: 'black' }} >
                    Close
                </Button>




            </Dialog>
        </>
    )
}

export default UploadVideos
// Get Request
const getRequest = async (url, value, token, type = null) => {
    try {
        const response = await fetch(`${url}?id=${value}&type=${type}`, {
            method: "GET",
            headers: {
                'Content-Type': 'application/json',
                 Authorization: `Bearer ${token}`
            }
        });

        const data = await response.json();
        return data; 

    } catch (error) {
        console.error('Error fetching data:', error);
        return null; 
    }
};

// Put or Update Request
const editRequest = async (url, userId, formData = null, token) => {
    try {
        const options = {
            method: "POST",
            headers: {
                Authorization: `Bearer ${token}`,
            }
        };

        if(formData instanceof FormData){
            options['body'] = formData;
        }

        const response = await fetch(`${url}?id=${userId}`, options);
        const data = await response.json();

        if(data){
            return data;
        }
    } catch (error) {
        console.error('Error fetching data:', error);
        return null; 
    }
}

// Post or View Request
const postRequest = async (url, token) => {
    const response = await fetch(url, {
        method: "POST",
        headers: {
            Authorization: `Bearer ${token}`
        }
    });

    const data = await response.json();
    return data;
}

// Delete Request 
const deleteRequest = async (url, userId, type, token) => {
    try {
        const response = await fetch(`${url}?id=${userId}&type=${type}`, {
            method: "DELETE",
            headers: {
                Authorization: `Bearer ${token}`
            }
        });
    
        const data = await response.json();
        if(data){
            return data;
        }
    } catch (error) {
        console.error('Error Deleting data:', error);
    }
}

const createRequest = async (url, formData, token) => {
    try {
        const response = await fetch(url, {
            method: "POST",
            headers: {
                Authorization: `Bearer ${token}`
            },
            body: formData
        });
    
        const data = await response.json();
        if(data){
            return data;
        }
    } catch (error) {
        console.error('Error Creating data:', error);
    }
}
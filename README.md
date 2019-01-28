# project_EFAT

## File
I divided the subjects into patient groups (PT) and healthy control groups (HC). They are in the different directory.

### Order
1. BIDS
2. Preprocessing (HC/PT)
3. Normalize (HC/PT)
4. FirstLevel (HC/PT)
5. SecondLevel (HC/PT/twosample)

### File name

#### data replication : Replicate the results of the orginal paper (MacNamara et al., 2017)
- **BIDS**: Change the file format into BIDS format
- **Preprocessing**: Do the preprocessing to anatomical image and functional images
- **Normalize**: Normalization
- **FirstLevel**: GLM
    - cont02: angry
    - cont03: fear
    - cont04: happy
    - cont05: sad
    - cont06: shape (control)
    - cont07: angry>shapes
    - cont08: fear>shapes
    - cont09: happy>shapes
    - cont10: sad>shapes
- **SecondLevel (PT)**: Doing multiple regression
- **SecondLevel (twosample)**: Doing twosample T-test

#### machine learning : Using machine learning algorithms for prediction & clustering
- **reconstruction**: Apply mask to 3D first-level image to make it 2D matrix

## Reference
MacNamara, A., Klumpp, H., Kennedy, A. E., Langenecker, S. A., Phan, K. L. J. D., & anxiety. (2017). Transdiagnostic neural correlates of affective face processing in anxiety and depression. 34(7), 621-631. 

@isTest
public class JDO_ManageMSPvaluesTest {

    @isTest
    static void testAddValue() {
        JDO_ManageMSPvalues.MSPRequest req = new JDO_ManageMSPvalues.MSPRequest();
        req.mspString = 'V1;V2';
        req.value = 'V3';
        req.operation = 'add';

        List<JDO_ManageMSPvalues.MSPResponse> result = JDO_ManageMSPvalues.manageMSP(new List<JDO_ManageMSPvalues.MSPRequest>{ req });

        Assert.areEqual(1, result.size(), 'Expected exactly one response');
        Set<String> expected = new Set<String>{ 'V1', 'V2', 'V3' };
        Set<String> actual = new Set<String>(result[0].updatedMspString.split(';'));
        Assert.areEqual(expected, actual, 'V3 should have been added to V1;V2');
    }

    @isTest
    static void testAddExistingValue() {
        JDO_ManageMSPvalues.MSPRequest req = new JDO_ManageMSPvalues.MSPRequest();
        req.mspString = 'V1;V2';
        req.value = 'V2';
        req.operation = 'add';

        List<JDO_ManageMSPvalues.MSPResponse> result = JDO_ManageMSPvalues.manageMSP(new List<JDO_ManageMSPvalues.MSPRequest>{ req });

        Assert.areEqual(1, result.size(), 'Expected exactly one response');
        Set<String> expected = new Set<String>{ 'V1', 'V2' };
        Set<String> actual = new Set<String>(result[0].updatedMspString.split(';'));
        Assert.areEqual(expected, actual, 'Adding an already-present value should not create a duplicate');
    }

    @isTest
    static void testRemoveValue() {
        JDO_ManageMSPvalues.MSPRequest req = new JDO_ManageMSPvalues.MSPRequest();
        req.mspString = 'V1;V2;V3';
        req.value = 'V2';
        req.operation = 'remove';

        List<JDO_ManageMSPvalues.MSPResponse> result = JDO_ManageMSPvalues.manageMSP(new List<JDO_ManageMSPvalues.MSPRequest>{ req });

        Assert.areEqual(1, result.size(), 'Expected exactly one response');
        Set<String> expected = new Set<String>{ 'V1', 'V3' };
        Set<String> actual = new Set<String>(result[0].updatedMspString.split(';'));
        Assert.areEqual(expected, actual, 'V2 should have been removed from the MSP string');
    }

    @isTest
    static void testRemoveNonexistentValue() {
        JDO_ManageMSPvalues.MSPRequest req = new JDO_ManageMSPvalues.MSPRequest();
        req.mspString = 'V1;V3';
        req.value = 'V2';
        req.operation = 'remove';

        List<JDO_ManageMSPvalues.MSPResponse> result = JDO_ManageMSPvalues.manageMSP(new List<JDO_ManageMSPvalues.MSPRequest>{ req });

        Assert.areEqual(1, result.size(), 'Expected exactly one response');
        Set<String> expected = new Set<String>{ 'V1', 'V3' };
        Set<String> actual = new Set<String>(result[0].updatedMspString.split(';'));
        Assert.areEqual(expected, actual, 'Removing a value not present in the MSP string should leave it unchanged');
    }

    @isTest
    static void testAddToEmptyMspString() {
        JDO_ManageMSPvalues.MSPRequest req = new JDO_ManageMSPvalues.MSPRequest();
        req.mspString = '';
        req.value = 'V1';
        req.operation = 'add';

        List<JDO_ManageMSPvalues.MSPResponse> result = JDO_ManageMSPvalues.manageMSP(new List<JDO_ManageMSPvalues.MSPRequest>{ req });

        Assert.areEqual(1, result.size(), 'Expected exactly one response');
        Set<String> expected = new Set<String>{ 'V1' };
        Set<String> actual = new Set<String>(result[0].updatedMspString.split(';'));
        Assert.areEqual(expected, actual, 'V1 should have been added to an empty MSP string');
    }

    @isTest
    static void testRemoveFromEmptyMspString() {
        JDO_ManageMSPvalues.MSPRequest req = new JDO_ManageMSPvalues.MSPRequest();
        req.mspString = '';
        req.value = 'V1';
        req.operation = 'remove';

        List<JDO_ManageMSPvalues.MSPResponse> result = JDO_ManageMSPvalues.manageMSP(new List<JDO_ManageMSPvalues.MSPRequest>{ req });

        Assert.areEqual(1, result.size(), 'Expected exactly one response');
        Assert.areEqual('', result[0].updatedMspString, 'Removing from an empty MSP string should return an empty string');
    }

    @isTest
    static void testNullValueDoesNotError() {
        JDO_ManageMSPvalues.MSPRequest req = new JDO_ManageMSPvalues.MSPRequest();
        req.mspString = 'V1;V2';
        req.value = null;
        req.operation = 'add';

        List<JDO_ManageMSPvalues.MSPResponse> result = JDO_ManageMSPvalues.manageMSP(new List<JDO_ManageMSPvalues.MSPRequest>{ req });

        Assert.areEqual(1, result.size(), 'Expected exactly one response');
        Set<String> expected = new Set<String>{ 'V1', 'V2' };
        Set<String> actual = new Set<String>(result[0].updatedMspString.split(';'));
        Assert.areEqual(expected, actual, 'A null value should not modify the existing MSP string');
    }

}
